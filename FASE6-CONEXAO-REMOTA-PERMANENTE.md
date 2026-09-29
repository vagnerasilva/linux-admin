# FASE 6: Conexão Remota Permanente (Redes Diferentes)

**Documento:** Guia Prático para Conexão entre MacBook e Ubuntu em Diferentes Casas/Redes  
**Data:** 2026-09-28  
**Status:** Referência de Implementação  

---

## 📋 Resumo Executivo

Quando o Ubuntu estiver em outra casa (diferente ISP, diferentes roteadores), você precisa:

1. **RustDesk** - Controle remoto visual (camada 1 - principal)
2. **SSH Reverse Tunnel** - Terminal + backup automático (camada 2 - fallback)
3. **Dynamic DNS** - Se o IP da Ubuntu mudar (camada 3 - apenas se necessário)
4. **Monitoramento** - Scripts para verificar se conexões estão ativas (camada 4 - log)

**Tempo de Setup:** 3-4 horas  
**Dificuldade:** 🟠 Média (requer SSH conhecimento básico)

---

## 🔧 SOLUÇÃO RECOMENDADA

### Stack Tecnológico

```
┌────────────────────────────────────────────────────────────┐
│         CAMADA DE APLICAÇÃO (Controle Remoto)              │
│  ┌──────────────────┐          ┌──────────────────┐        │
│  │  RustDesk Client │          │  RustDesk Server │        │
│  │   (MacBook)      │ ◄────►   │    (Ubuntu)      │        │
│  └──────────────────┘  P2P     └──────────────────┘        │
│          │                              │                   │
│          └──────────────────┬───────────┘                   │
│                             │                               │
│         AUTO-RELAY FALLBACK (se P2P falhar)                 │
│         RustDesk Public Relay Server                        │
│                                                              │
├────────────────────────────────────────────────────────────┤
│      CAMADA DE TUNELAMENTO (Backup + SSH)                   │
│  ┌──────────────────┐          ┌──────────────────┐        │
│  │   MacBook SSH    │ ◄────►   │  SSH Reverse     │        │
│  │   Server (Port  ││  TUNNEL  │  Tunnel Daemon   │        │
│  │   2222)          │          │   (Ubuntu)       │        │
│  └──────────────────┘          └──────────────────┘        │
│          ▲                              ▲                   │
│          │  Reconnect Every 30s        │                    │
│          └──────────────────┬──────────┘                    │
│                             │                               │
├────────────────────────────────────────────────────────────┤
│       CAMADA DE DESCOBERTA (Dynamic DNS)                    │
│  ubuntu.no-ip.biz ─────────► Resolves to Current IP        │
│                                                              │
├────────────────────────────────────────────────────────────┤
│              CAMADA DE REDE (Internet)                      │
│  MacBook (54.232.189.113) ◄──────► Ubuntu (203.0.113.45)   │
│          [ISP A]                        [ISP B]             │
│                                                              │
└────────────────────────────────────────────────────────────┘
```

---

## 🚀 PASSO A PASSO IMPLEMENTAÇÃO

### PASSO 1: RustDesk com Auto-Reconexão (Ubuntu)

#### 1.1 - Instalar RustDesk
```bash
# No Ubuntu
wget https://github.com/rustdesk/rustdesk/releases/download/1.2.4/rustdesk-1.2.4.deb
sudo apt install ./rustdesk-1.2.4.deb
```

#### 1.2 - Obter ID do RustDesk
```bash
# Executar RustDesk
rustdesk &

# Nota o ID gerado (ex: 123456789)
# Salvar em local seguro
echo "ID RUSTDESK: 123456789" >> ~/Linux-Admin-Project/docs/rustdesk-config.txt
```

#### 1.3 - Configurar Auto-Start (Ubuntu)
```bash
# Criar serviço systemd
sudo tee /etc/systemd/system/rustdesk.service > /dev/null <<EOF
[Unit]
Description=RustDesk Remote Desktop Server
After=network-online.target
Wants=network-online.target

[Service]
Type=simple
User=root
ExecStart=/usr/bin/rustdesk --server
Restart=always
RestartSec=5
StandardOutput=journal
StandardError=journal

[Install]
WantedBy=multi-user.target
EOF

# Ativar serviço
sudo systemctl daemon-reload
sudo systemctl enable rustdesk
sudo systemctl start rustdesk

# Verificar
sudo systemctl status rustdesk
```

#### 1.4 - Definir Senha Permanente (Ubuntu)
```bash
# No Ubuntu, abrir RustDesk GUI
rustdesk

# Settings → Security → Set Password
# Escolher senha forte (mínimo 8 caracteres)
# Anotar em local seguro
```

#### 1.5 - Testar RustDesk (MacBook)
```bash
# Instalar RustDesk no MacBook
brew install rustdesk

# Abrir e conectar usando ID do Ubuntu
# Menu: Connect to Remote Desktop
# ID: [cole ID da Ubuntu]
# Senha: [senha definida]

# Testar controle: mover mouse, digitar, etc
```

---

### PASSO 2: SSH Reverse Tunnel (Backup Automático)

#### 2.1 - Gerar Chaves SSH no Ubuntu
```bash
# No Ubuntu, como root
sudo su -
mkdir -p ~/.ssh
ssh-keygen -t ed25519 -f ~/.ssh/tunnel_key -N "" -C "ubuntu-tunnel"

# Visualizar chave pública
cat ~/.ssh/tunnel_key.pub
```

#### 2.2 - Adicionar Chave Pública no MacBook
```bash
# No MacBook
mkdir -p ~/.ssh
chmod 700 ~/.ssh

# Copiar conteúdo da chave pública do Ubuntu (output anterior)
# E adicionar em ~/.ssh/authorized_keys
echo "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIxxxxxx ubuntu-tunnel@ubuntu" >> ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys
```

#### 2.3 - Criar Script de Manutenção do Tunnel (Ubuntu)
```bash
# No Ubuntu, criar arquivo: /usr/local/bin/ssh-tunnel-keeper.sh
sudo tee /usr/local/bin/ssh-tunnel-keeper.sh > /dev/null <<'EOFSCRIPT'
#!/bin/bash

# CONFIGURAÇÕES
MAC_USER="seu_usuario_mac"              # Mudar!
MAC_HOSTNAME="seu.macbook.ip"          # Mudar! ou hostname
MAC_SSH_PORT="22"                       # Porta SSH do MacBook
TUNNEL_PORT="2223"                      # Porta local que forward para SSH do Mac
LOG_FILE="/var/log/ssh-tunnel-keeper.log"
PID_FILE="/var/run/ssh-tunnel-keeper.pid"
RETRY_INTERVAL="30"                     # Tentar reconectar a cada 30s

# Função de log
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >> $LOG_FILE
}

# Função para iniciar tunnel
start_tunnel() {
    log "Iniciando SSH reverse tunnel para $MAC_HOSTNAME:$MAC_SSH_PORT"
    
    # Matar processo anterior
    if [ -f $PID_FILE ]; then
        kill $(cat $PID_FILE) 2>/dev/null || true
    fi
    
    # Iniciar novo tunnel
    ssh -R $TUNNEL_PORT:localhost:22 \
        -i /root/.ssh/tunnel_key \
        -N -f \
        -o StrictHostKeyChecking=no \
        -o UserKnownHostsFile=/dev/null \
        -o ConnectTimeout=10 \
        -o ServerAliveInterval=60 \
        -o ServerAliveCountMax=3 \
        $MAC_USER@$MAC_HOSTNAME -p $MAC_SSH_PORT
    
    local pid=$!
    echo $pid > $PID_FILE
    log "✅ Tunnel iniciado com PID $pid"
}

# Loop de verificação
log "=== SSH Tunnel Keeper iniciado ==="

while true; do
    local pid=$(cat $PID_FILE 2>/dev/null)
    
    if [ -z "$pid" ] || ! kill -0 $pid 2>/dev/null; then
        log "⚠️ Tunnel inativo, reconectando..."
        start_tunnel
    else
        # Apenas logar sucesso a cada 5 minutos (evitar log muito grande)
        if [ $(($(date +%s) % 300)) -lt 30 ]; then
            log "✅ Tunnel ativo (PID $pid)"
        fi
    fi
    
    sleep $RETRY_INTERVAL
done
EOFSCRIPT

sudo chmod +x /usr/local/bin/ssh-tunnel-keeper.sh
```

#### 2.4 - Criar Serviço SystemD (Ubuntu)
```bash
# No Ubuntu
sudo tee /etc/systemd/system/ssh-tunnel-keeper.service > /dev/null <<EOF
[Unit]
Description=SSH Reverse Tunnel Keeper
After=network-online.target
Wants=network-online.target

[Service]
Type=simple
User=root
ExecStart=/usr/local/bin/ssh-tunnel-keeper.sh
Restart=always
RestartSec=10
StandardOutput=journal
StandardError=journal

[Install]
WantedBy=multi-user.target
EOF

# Ativar
sudo systemctl daemon-reload
sudo systemctl enable ssh-tunnel-keeper
sudo systemctl start ssh-tunnel-keeper

# Verificar
sudo systemctl status ssh-tunnel-keeper
journalctl -u ssh-tunnel-keeper -f
```

#### 2.5 - Usar SSH Tunnel (MacBook)
```bash
# Adicionar em ~/.ssh/config
cat >> ~/.ssh/config <<EOF

Host ubuntu-tunnel
    HostName localhost
    Port 2223
    User admin_seu_nome
    IdentityFile ~/.ssh/ubuntu_admin_key
    StrictHostKeyChecking no
    UserKnownHostsFile=/dev/null
EOF

# Conectar via tunnel
ssh ubuntu-tunnel

# Transferir arquivo via tunnel
scp -P 2223 arquivo.txt admin_seu_nome@localhost:~/
```

---

### PASSO 3: Dynamic DNS (Se IP Mudar)

#### 3.1 - Instalar Cliente DDNS (Ubuntu)
```bash
# No Ubuntu
sudo apt install -y ddclient

# Criar conta em serviço DDNS
# Opções gratuitas:
#   - No-IP (https://www.noip.com/)
#   - DynDNS (https://dyn.com/)
#   - Cloudflare (se usar seu domínio)

# Após criar conta, anotar:
# - Username: ________________
# - Password: ________________
# - Hostname: ubuntu.no-ip.biz
```

#### 3.2 - Configurar DDClient (Ubuntu)
```bash
# No Ubuntu
sudo nano /etc/ddclient.conf

# Substituir por (exemplo No-IP):
protocol=noip
use=web
web=dynamicupdate.no-ip.com/nic/update
login=seu_email@no-ip.com
password=sua_senha
ubuntu.no-ip.biz

# Salvar (Ctrl+O, Enter, Ctrl+X)

# Ativar serviço
sudo systemctl enable ddclient
sudo systemctl start ddclient
sudo systemctl status ddclient
```

#### 3.3 - Testar DDNS (MacBook)
```bash
# Verificar se hostname resolve para IP correto
nslookup ubuntu.no-ip.biz

# Resultado esperado:
# ubuntu.no-ip.biz	A	203.0.113.45  (qualquer IP externo)

# Se não funcionar, aguardar 5-10 minutos (propagação DNS)
```

#### 3.4 - Usar DDNS em Conexões (MacBook)
```bash
# Atualizar ~/.ssh/config
cat >> ~/.ssh/config <<EOF

Host ubuntu-remoto
    HostName ubuntu.no-ip.biz      # Em vez de IP estático
    Port 2222
    User admin_seu_nome
    IdentityFile ~/.ssh/ubuntu_admin_key
EOF

# Conectar
ssh ubuntu-remoto
```

---

### PASSO 4: Monitoramento de Conexão (MacBook)

#### 4.1 - Criar Script de Verificação
```bash
# No MacBook, criar: ~/Linux-Admin-Project/scripts/check-connection.sh
cat > ~/Linux-Admin-Project/scripts/check-connection.sh <<'EOFSCRIPT'
#!/bin/bash

UBUNTU_HOSTNAME="ubuntu.no-ip.biz"      # ou IP
UBUNTU_PORT="2222"
LOG_FILE="$HOME/Linux-Admin-Project/logs/connection-monitor.log"

echo "=== Check Connection $(date '+%Y-%m-%d %H:%M:%S') ===" >> $LOG_FILE

# Teste 1: SSH direto
if timeout 5 ssh -o ConnectTimeout=5 -p $UBUNTU_PORT -i ~/.ssh/ubuntu_admin_key admin_seu_nome@$UBUNTU_HOSTNAME "echo 'OK'" > /dev/null 2>&1; then
    SSH_STATUS="✅ SSH OK"
else
    SSH_STATUS="❌ SSH FALHA"
fi

# Teste 2: RustDesk respondendo (se aplicável)
if pgrep -x "RustDesk" > /dev/null 2>&1; then
    RD_STATUS="✅ RustDesk OK"
else
    RD_STATUS="❌ RustDesk Not Running"
fi

# Teste 3: DNS resolvendo
if timeout 5 nslookup $UBUNTU_HOSTNAME > /dev/null 2>&1; then
    DNS_STATUS="✅ DNS OK"
else
    DNS_STATUS="❌ DNS FALHA"
fi

echo "SSH: $SSH_STATUS | RustDesk: $RD_STATUS | DNS: $DNS_STATUS" >> $LOG_FILE

# Alerta se tudo falhar
if [[ "$SSH_STATUS" == "❌"* && "$RD_STATUS" == "❌"* ]]; then
    echo "⚠️⚠️⚠️ ALERTA: Ambas conexões indisponíveis! ⚠️⚠️⚠️" >> $LOG_FILE
fi
EOFSCRIPT

chmod +x ~/Linux-Admin-Project/scripts/check-connection.sh
```

#### 4.2 - Agendar Verificação Periódica (MacBook)
```bash
# Criar LaunchAgent
mkdir -p ~/Library/LaunchAgents

cat > ~/Library/LaunchAgents/com.local.connection-monitor.plist <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.local.connection-monitor</string>
    <key>ProgramArguments</key>
    <array>
        <string>/bin/bash</string>
        <string>$HOME/Linux-Admin-Project/scripts/check-connection.sh</string>
    </array>
    <key>StartInterval</key>
    <integer>300</integer>  <!-- Executar a cada 5 minutos -->
    <key>StandardOutPath</key>
    <string>$HOME/Linux-Admin-Project/logs/monitor-stdout.log</string>
    <key>StandardErrorPath</key>
    <string>$HOME/Linux-Admin-Project/logs/monitor-stderr.log</string>
</dict>
</plist>
EOF

# Carregar
launchctl load ~/Library/LaunchAgents/com.local.connection-monitor.plist

# Verificar se está rodando
launchctl list | grep connection-monitor
```

#### 4.3 - Visualizar Logs
```bash
# Ver logs em tempo real
tail -f ~/Linux-Admin-Project/logs/connection-monitor.log

# Ver últimas 50 linhas
tail -50 ~/Linux-Admin-Project/logs/connection-monitor.log

# Buscar por falhas
grep "❌" ~/Linux-Admin-Project/logs/connection-monitor.log
```

---

## ✅ CHECKLIST DE IMPLEMENTAÇÃO

### Pré-Requisitos
- [ ] Ubuntu tem acesso à internet (confirmar com `ping google.com`)
- [ ] MacBook tem acesso à internet
- [ ] Você conhece username/password do MacBook
- [ ] Ubuntu é Ubuntu 24.04 LTS ou compatível
- [ ] Você tem acesso físico ao Ubuntu (pelo menos para setup inicial)

### RustDesk (Obrigatório)
- [ ] RustDesk instalado em Ubuntu
- [ ] RustDesk instalado em MacBook
- [ ] ID do RustDesk anotado: `_______________________`
- [ ] Senha permanente definida: `_______________________`
- [ ] Serviço systemd criado e ativo
- [ ] Teste de conexão bem-sucedido
- [ ] Controle remoto funcionando (mover mouse, digitar)

### SSH Reverse Tunnel (Recomendado)
- [ ] Chaves SSH geradas no Ubuntu
- [ ] Chave pública adicionada em MacBook ~/.ssh/authorized_keys
- [ ] Script ssh-tunnel-keeper.sh criado e testado
- [ ] Serviço systemd criado
- [ ] Teste de conexão via `ssh ubuntu-tunnel`
- [ ] Arquivo ~/.ssh/config atualizado

### Dynamic DNS (Obrigatório se IP Dinâmico)
- [ ] Conta DDNS criada (No-IP, etc)
- [ ] ddclient instalado no Ubuntu
- [ ] /etc/ddclient.conf configurado
- [ ] nslookup retorna IP correto
- [ ] Hostname resolve mesmo após reiniciar Ubuntu

### Monitoramento (Recomendado)
- [ ] Script check-connection.sh criado
- [ ] LaunchAgent configurado no MacBook
- [ ] Logs sendo gerados em ~/Linux-Admin-Project/logs/
- [ ] Alertas funcionando quando conexão falha

### Testes Finais
- [ ] Desconectar MacBook da Wi-Fi e reconectar (simular mudança de rede)
- [ ] Testar RustDesk durante transição
- [ ] Testar SSH Tunnel durante transição
- [ ] Verificar que monitoramento detectou a mudança
- [ ] Confirmar reconexão automática funcionou
- [ ] Revisar logs de conexão

---

## 🔍 TROUBLESHOOTING

### RustDesk não conecta
```bash
# No Ubuntu
sudo systemctl restart rustdesk
sudo journalctl -u rustdesk -f

# No MacBook
# Tente conectar novamente
# Se ID estiver correto, espere 30s para P2P falhar e relay assumir
# Se relay também falhar, verificar firewall
```

### SSH Tunnel não funciona
```bash
# No Ubuntu - verificar status
sudo systemctl status ssh-tunnel-keeper
sudo journalctl -u ssh-tunnel-keeper -f

# No MacBook - testar conexão manual
ssh -vvv ubuntu-tunnel

# Erros comuns:
# - "Permission denied" = chave pública não adicionada ao MacBook
# - "Connection refused" = MacBook SSH server não está rodando
# - "Timeout" = firewall bloqueando
```

### Dynamic DNS não atualiza
```bash
# No Ubuntu
sudo systemctl status ddclient
sudo ddclient -force  # Forçar atualização

# Verificar
nslookup ubuntu.no-ip.biz

# Se não resolver:
# - Aguardar 5-10 minutos (propagação DNS)
# - Verificar credenciais em /etc/ddclient.conf
# - Checklist serviço: sudo systemctl restart ddclient
```

### Conexão cai frequentemente
```bash
# Aumentar heartbeat no SSH
# Em ~/Linux-Admin-Project/scripts/ssh-tunnel-keeper.sh
# Alterar: ServerAliveInterval=60 para ServerAliveInterval=30

# Reiniciar daemon
sudo systemctl restart ssh-tunnel-keeper

# Verificar logs
sudo journalctl -u ssh-tunnel-keeper -n 100
```

---

## 📊 MATRIZ DE DECISÃO: Qual Ferramenta Usar?

| Situação | RustDesk | SSH Tunnel | WireGuard | DDNS |
|----------|----------|-----------|-----------|------|
| Controle visual remoto | ✅✅✅ | ❌ | ❌ | ⚠️ |
| Terminal SSH | ✅ | ✅✅✅ | ✅ | ⚠️ |
| Transferir arquivos | ✅✅✅ | ✅ | ✅ | ⚠️ |
| Reconexão automática | ✅✅ | ✅✅✅ | ✅✅ | N/A |
| Requer abertura de porta | ❌ | ❌ | ⚠️ | N/A |
| Fácil de configurar | ✅✅✅ | ✅ | ❌ | ✅✅ |
| IP Dinâmico | ✅✅ | ⚠️ | ⚠️ | ✅✅✅ |
| Custo | 🆓 | 🆓 | 🆓 | 🆓 |

**Recomendação:** Use **RustDesk + SSH Tunnel + DDNS** como stack completo.

---

## 📞 SUPORTE RÁPIDO

| Problema | Solução |
|----------|---------|
| "Connection refused" | Verificar se SSH server está rodando: `sudo systemctl status ssh` |
| "Permission denied" | Checar se chave pública está em `~/.ssh/authorized_keys` |
| "Timeout" | Firewall bloqueando? Usar SSH Reverse Tunnel (não requer porta aberta) |
| IP mudou mas RustDesk não conecta | Aguardar relay fallback (30s), ou usar SSH Tunnel |
| Quer conectar rapidamente | Use RustDesk (visual, mais fácil) |
| Precisa de acesso terminal | Use SSH Tunnel ou RustDesk terminal |
| Precisa de acesso rede completa | Use WireGuard VPN |

---

## 📚 Próximas Leituras

- [SSH Reverse Tunneling Guide](https://www.ssh.com/ssh/tunneling/reverse)
- [RustDesk Architecture](https://rustdesk.com/docs/en/architecture/)
- [Dynamic DNS Explained](https://en.wikipedia.org/wiki/Dynamic_DNS)
- [Ubuntu SSH Server Security](https://ubuntu.com/server/docs/service-openssh)

---

**Criado em:** 2026-09-28  
**Versão:** 1.0  
**Status:** Pronto para Implementação
