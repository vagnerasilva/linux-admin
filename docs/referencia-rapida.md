# Referência Rápida: Comandos Úteis

**Guia de bolso com comandos mais usados**

---

## 🚀 Começar Rápido

```bash
# Verificar ambiente
bash ~/Linux-Admin-Project/scripts/00-verificar-ambiente.sh

# Instalar ferramentas
bash ~/Linux-Admin-Project/scripts/01-instalacoes.sh

# Gerar chaves SSH
bash ~/Linux-Admin-Project/scripts/gen-ssh-keys.sh

# Verificar conectividade
bash ~/Linux-Admin-Project/scripts/check-connection.sh
```

---

## 🔐 SSH Básico

```bash
# Conectar via SSH direto
ssh -i ~/.ssh/ubuntu_admin_key -p 2222 admin_teste@192.168.0.100

# Conectar usando config (mais fácil)
ssh ubuntu-direct

# Copiar arquivo para Ubuntu
scp -P 2222 arquivo.txt admin_teste@192.168.0.100:~/

# Copiar arquivo do Ubuntu para MacBook
scp -P 2222 admin_teste@192.168.0.100:~/arquivo.txt .

# Fazer tunneling de porta (ex: acesso HTTP local)
ssh -L 8080:localhost:80 ubuntu-direct

# Port forwarding reverso
ssh -R 2223:localhost:22 ubuntu-direct
```

---

## 🖥️ Conectar ao Ubuntu

### Via SSH Terminal
```bash
ssh ubuntu-direct        # Config setup
ssh ubuntu-tunnel        # Via reverse tunnel
```

### Via RDP (Desktop)
```bash
# No MacBook, abrir Microsoft Remote Desktop
# Conectar para: 192.168.0.100:3389
# Usuário: admin_teste
# Senha: (conforme definido)
```

### Via RustDesk
```bash
# No MacBook, abrir RustDesk
# Inserir ID da Ubuntu
# Conectar
```

---

## 📋 Gerenciamento de Projeto

```bash
# Ir para diretório do projeto
cd ~/Linux-Admin-Project

# Ver estrutura
tree -L 2

# Ver logs
tail -f logs/setup.log
tail -f logs/connection-monitor.log

# Fazer backup
tar -czf backups/ubuntu-config-$(date +%Y%m%d).tar.gz configs/ scripts/

# Ver chaves SSH
ls -la ssh-keys/

# Ver configurações
ls -la configs/

# Ver documentação
ls docs/
```

---

## 🔑 Gerenciamento de Chaves SSH

```bash
# Gerar novas chaves
bash scripts/gen-ssh-keys.sh

# Verificar chaves geradas
cat ssh-keys/ubuntu_admin_key.pub

# Copiar chave pública para clipboard (macOS)
cat ssh-keys/ubuntu_admin_key.pub | pbcopy

# Permitir chave em Ubuntu
# (executar NO Ubuntu)
echo "CHAVE_PUBLICA" >> ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys

# Testar chave
ssh -i ssh-keys/ubuntu_admin_key admin_teste@192.168.0.100
```

---

## 🌐 Rede e Conectividade

```bash
# Testar ping
ping -c 3 192.168.0.100

# Ver IPs locais
ifconfig | grep "inet " | grep -v 127.0.0.1

# Testar porta SSH
nc -zv 192.168.0.100 2222

# Testar porta RDP
nc -zv 192.168.0.100 3389

# Ver DNS resolvendo
nslookup ubuntu.no-ip.biz

# Ver rotas de rede
netstat -rn | grep default
```

---

## 📝 Logs e Troubleshooting

```bash
# Ver último erro SSH
ssh -v ubuntu-direct 2>&1 | tail -20

# Ver todos os logs
cat logs/*.log

# Filtrar por data
grep "2026-09-28" logs/*.log

# Ver erros específicos
grep "ERROR\|FAIL" logs/*.log

# Limpar logs antigos
rm logs/*.log

# Fazer backup de logs
tar -czf backups/logs-backup-$(date +%Y%m%d).tar.gz logs/
```

---

## 🔧 Configuração SSH

```bash
# Editar SSH config
nano ~/.ssh/config

# Verificar sintaxe SSH config
ssh -G ubuntu-direct

# Testar SSH sem conectar
ssh -T ubuntu-direct

# SSH com verbosidade (debug)
ssh -vvv ubuntu-direct

# Usar passphrase com ssh-agent
ssh-add ssh-keys/ubuntu_admin_key
ssh ubuntu-direct  # Não pedirá passphrase
```

---

## 📦 Gerenciamento de VM (Parallels)

```bash
# Listar VMs
prlctl list -a

# Iniciar VM
prlctl start Ubuntu-Test-01

# Parar VM
prlctl stop Ubuntu-Test-01

# Criar snapshot
prlctl snapshot Ubuntu-Test-01 create --name "snapshot-name"

# Restaurar snapshot
prlctl snapshot Ubuntu-Test-01 restore "snapshot-name"

# Listar snapshots
prlctl snapshot Ubuntu-Test-01 list
```

---

## 🔍 Verificações Importantes

```bash
# Verificar SSH server rodando (no Ubuntu)
sudo systemctl status ssh

# Reiniciar SSH (no Ubuntu)
sudo systemctl restart ssh

# Ver status de auditd (no Ubuntu)
sudo systemctl status auditd

# Verificar DNS (no Ubuntu)
resolvectl status

# Ver logs de auditoria (no Ubuntu)
sudo tail -f /var/log/audit/audit.log

# Verificar contas (no Ubuntu)
cat /etc/passwd | grep -E 'admin|adolescente'

# Verificar privilégios sudo (no Ubuntu)
sudo grep -r "NOPASSWD" /etc/sudoers.d/
```

---

## 📊 Monitoramento

```bash
# Verificar conexões ativas
bash scripts/check-connection.sh

# Ver bandwidth usado
# macOS não tem nethogs, use:
nettop  # ou Activity Monitor → Network

# Monitorar SSH login
# No Ubuntu:
tail -f /var/log/auth.log | grep ssh

# Monitorar tráfego de rede
# No Ubuntu (se Zeek instalado):
tail -f /opt/zeek/logs/current/dns.log
tail -f /opt/zeek/logs/current/conn.log
```

---

## 💾 Backup e Restore

```bash
# Fazer backup config Ubuntu (no Ubuntu)
sudo tar -czf /tmp/ubuntu-backup.tar.gz /etc/ssh /etc/sudoers.d /etc/audit

# Copiar backup para MacBook
scp admin_teste@192.168.0.100:/tmp/ubuntu-backup.tar.gz backups/

# Restaurar backup (no Ubuntu)
sudo tar -xzf ubuntu-backup.tar.gz -C /

# Backup automático
tar -czf backups/config-$(date +%Y%m%d-%H%M%S).tar.gz configs/ scripts/
```

---

## 🎓 Editar Arquivos em Ubuntu via SCP

```bash
# Editar arquivo remoto localmente
# Download → Edit → Upload

# Download
scp admin_teste@192.168.0.100:/etc/ssh/sshd_config ~/sshd_config.bak

# Editar localmente
nano ~/sshd_config.bak

# Upload de volta
scp ~/sshd_config.bak admin_teste@192.168.0.100:/etc/ssh/sshd_config

# (Pode precisar sudo se permissões)
```

---

## 📞 Troubleshooting Rápido

| Problema | Comando | Solução |
|----------|---------|---------|
| SSH não conecta | `ssh -v ubuntu-direct` | Ver erro específico |
| Ping não funciona | `ping 192.168.0.100` | Verificar rede/firewall |
| Porta SSH fechada | `nc -zv HOST 2222` | Verificar firewall |
| Chave rejeita | `ssh -vvv ubuntu-direct` | Verificar authorized_keys |
| RDP não funciona | `nc -zv HOST 3389` | Verificar se xrdp está rodando |
| Memória full | (no Ubuntu) `free -h` | Limpar ou expandir VM |

---

## 🔐 Segurança

```bash
# Verificar permissões de chaves
ls -la ~/.ssh/

# Permissões corretas devem ser:
# -rw-------  (600) para private keys
# -rw-r--r--  (644) para public keys
# drwx------  (700) para ~/.ssh/

# Remover chaves antigas/inseguras
rm ~/.ssh/known_hosts

# Bloquear chave (se comprometida)
ssh-keygen -p -f ssh-keys/ubuntu_admin_key -N "" -P "nova_passphrase"
```

---

## 📖 Leitura Adicional

- [planejamento.md](../linux_project/planejamento.md) - Completo
- [ROADMAP-VISUAL.md](../linux_project/ROADMAP-VISUAL.md) - Visão geral
- [FASE-0.5-SETUP-VM-RAPIDO.md](../linux_project/FASE-0.5-SETUP-VM-RAPIDO.md) - VM
- [FASE6-CONEXAO-REMOTA-PERMANENTE.md](../linux_project/FASE6-CONEXAO-REMOTA-PERMANENTE.md) - Redes

---

**Última Atualização:** 2026-09-28  
**Versão:** 1.0
