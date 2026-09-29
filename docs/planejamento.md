# Planejamento: Ambiente de Auditoria, Controle Parental e Acesso Remoto

**Data de Criação:** 2026-09-28  
**Objetivo:** Configurar cenário de administração segura entre MacBook (admin) e Ubuntu 24.04 LTS (usuário adolescente)  
**Status:** Em Planejamento

---

## 📊 STATUS ATUAL DO PROJETO (2026-09-28)

### MacBook (Admin)
```
Sistema:        macOS 26.5.2 (Sequoia)
Arquitetura:    arm64 (Apple Silicon)
OpenSSH:        10.2p1 (LibreSSL 3.3.6) ✅
Homebrew:       7.0.4 ✅
Git:            2.50.1 ✅
Microsoft RDP:  ❌ NÃO INSTALADO
IP Local:       192.168.0.63
Projeto Dir:    ❌ Não criado
```

### Ubuntu 24.04 LTS - VIRTUAL MACHINE (Teste)
```
Status:         ⏳ Será criada como VM
Tipo:           ⏳ Escolher hypervisor (VMware/Parallels/VirtualBox)
Acesso:         ⏳ Rede bridge ou NAT no MacBook
Contas:         ⏳ Será configurar em Fase 1 (na VM)
```

### Ubuntu 24.04 LTS - MÁQUINA OFICIAL (Futura)
```
Status:         ⏳ Aguardando hypervisor
Acesso:         ⏳ Depois que VM estiver testada
Contas:         ⏳ Replicar configuração da VM
```

### Progresso Geral
| Etapa | Status | Tarefas |
|------|--------|---------|
| 0.0 | 🟠 Em Progresso | 1. Instalar MS Remote Desktop<br>2. Criar estrutura de diretórios |
| 0.5 | ⏳ Preparação VM | 1. Escolher hypervisor<br>2. Criar VM Ubuntu<br>3. Configurar rede VM |
| 1-5 (VM) | ⏳ Testes | Executar todas as fases na VM |
| Migração | ⏳ Produção | Copiar configuração para máquina oficial |

---

## 📋 ANÁLISE DO PROMPT

### Objetivo Final
Criar um ambiente de monitoramento, auditoria e controle parental que:
- Permita acesso remoto seguro do MacBook ao Ubuntu
- Impossibilite o usuário adolescente de desativar proteções
- Registre todas as atividades (comandos, sites visitados, tráfego)
- Funcione inicialmente no MacBook (terminal e GUI) com suporte futuro para máquina Linux

### Componentes Principais
1. **Administração de Contas** - Separação de privilégios
2. **Controle de Conteúdo** - DNS seguro, bloqueio de bypass
3. **Auditoria de Sistema** - Logs de execução e tráfego
4. **Acesso Remoto SSH** - Terminal seguro (chaves RSA)
5. **Acesso Remoto Gráfico** - RDP (Microsoft Remote Desktop)
6. **Acesso Remoto Extrarede** - RustDesk P2P

---

## 🏗️ FASES DE IMPLEMENTAÇÃO

### FASE 0: PRÉ-REQUISITOS E PREPARAÇÃO
**Duração Estimada:** 2-4 horas  
**Local:** MacBook

#### 0.0 - STATUS ATUAL DO MACBOOK (Relatório de Requisitos - 2026-09-28)

**SISTEMA OPERACIONAL**
- ✅ macOS 26.5.2 (Sequoia) - Build 25F84
- ✅ Arquitetura: arm64 (Apple Silicon)

**FERRAMENTAS SSH (CRÍTICAS)**
- ✅ OpenSSH 10.2p1 com LibreSSL 3.3.6 (INSTALADO)
- ✅ ssh, scp, sftp, ssh-keygen disponíveis
- ✅ Terminal.app nativo disponível
- ❌ Arquivo ~/.ssh/config não existe (será criado)

**REMOTE DESKTOP**
- ❌ Microsoft Remote Desktop NÃO INSTALADO (AÇÃO NECESSÁRIA)

**FERRAMENTAS DE REDE**
- ✅ netcat (nc) disponível
- ✅ ping disponível
- ✅ traceroute disponível
- ❌ nmap não instalado (opcional)

**GERENCIADOR DE PACOTES**
- ✅ Homebrew 7.0.4 instalado
- ✅ Git 2.50.1 (Apple Git-155) instalado

**CONECTIVIDADE DE REDE**
- ✅ IP Local (LAN): **192.168.0.63** / 255.255.255.0
- ✅ IP Externo: 54.232.189.113
- ✅ Wi-Fi ativo e funcionando
- ✅ Pronto para conectar a Ubuntu na rede 192.168.0.x

**ESTRUTURA DE PROJETO**
- ❌ ~/Linux-Admin-Project não existe (será criado)

**AÇÕES IMEDIATAS NECESSÁRIAS**
1. [ ] Instalar Microsoft Remote Desktop: `brew install microsoft-remote-desktop`
2. [ ] Criar estrutura de diretórios: `mkdir -p ~/Linux-Admin-Project/{configs,scripts,logs,ssh-keys,docs}`
3. [ ] Copiar planejamento para projeto
4. [ ] Obter IP ou hostname do Ubuntu

---

#### 0.1 - Inventário de Máquinas
- [ ] **MacBook**
  - Verificar versão macOS (`sw_vers`)
  - Verificar Terminal.app ou iTerm2 disponível
  - Confirmar acesso SSH nativo (OpenSSH incluso)
  - Confirmar Microsoft Remote Desktop disponível (App Store ou brew)
  
- [ ] **Ubuntu (Futuro)**
  - Modelo exato: `Ubuntu 24.04 LTS (Noble Numbat)`
  - Desktop: `GNOME`
  - Arquitetura: x86_64 (ou ARM se Mac Silicon no futuro)
  - Acesso físico/remoto durante setup

#### 0.2 - Ferramentas Necessárias no MacBook
- [ ] Homebrew instalado: `brew --version`
- [ ] OpenSSH atualizado: `ssh -V`
- [ ] scp/sftp disponível: `scp` (vem com OpenSSH)
- [ ] Text editor: VS Code, Sublime, ou nano
- [ ] Terminal adequado (Terminal.app ou iTerm2)

#### 0.3 - Planejamento de Rede
- [ ] Rede LAN entre MacBook e Ubuntu
  - IP estático ou DHCP com reserva para Ubuntu?
  - Subnet: `192.168.x.x/24` (típico)?
  - Gateway/router: Como será o roteamento?
  
- [ ] Rede Remota (RustDesk)
  - Ambos conectados à internet?
  - Firewall permitirá conexão sainte (outbound)?
  - Servidor relay RustDesk público ou privado?

#### 0.4 - Criação de Estrutura de Diretórios (MacBook)
```bash
# No MacBook, criar estrutura para documentação
mkdir -p ~/Linux-Admin-Project/
mkdir -p ~/Linux-Admin-Project/configs/
mkdir -p ~/Linux-Admin-Project/scripts/
mkdir -p ~/Linux-Admin-Project/logs/
mkdir -p ~/Linux-Admin-Project/ssh-keys/
mkdir -p ~/Linux-Admin-Project/docs/
```

---

### FASE 0.5: PREPARAR MÁQUINA VIRTUAL DE TESTE
**Duração Estimada:** 2-3 horas  
**Local:** MacBook (criar VM Ubuntu 24.04 LTS)  
**Objetivo:** Ambiente de testes controlado antes de máquina oficial

#### 0.5.1 - Escolher Hypervisor

**Opções disponíveis para MacBook Apple Silicon (arm64):**

| Hypervisor | Custo | Facilidade | Compatibilidade arm64 | Recomendação |
|-----------|-------|-----------|----------------------|--------------|
| **VMware Fusion** | 💰💰 Pago | ✅ Fácil | ✅ Perfeito | 🟢 MELHOR |
| **Parallels Desktop** | 💰💰 Pago | ✅✅ Muito Fácil | ✅✅ Otimizado | 🟢 MELHOR |
| **UTM** | 🆓 Gratuito | ⚠️ Técnico | ✅ Bom | 🟡 Alternativa |
| **VirtualBox** | 🆓 Gratuito | ⚠️ Técnico | ⚠️ Experimental | 🔴 Não recomenda |

**Recomendação:** 
- **Se quiser fácil:** Parallels Desktop (melhor UX para MacBook)
- **Se quiser grátis:** UTM (totalmente funcional)
- **Se tiver licença:** VMware Fusion (profissional)

#### 0.5.2 - Instalar Hypervisor Escolhido

**Opção A: Parallels Desktop (Recomendado - Mais Fácil)**
```bash
# Via App Store ou Homebrew
brew install parallels

# Ou baixar em https://www.parallels.com/products/desktop/
# Incluir trial de 14 dias (suficiente para testes)
```

**Opção B: VMware Fusion Pro**
```bash
# Baixar em https://www.vmware.com/products/fusion/fusion-evaluation.html
# Incluir trial de 30 dias
```

**Opção C: UTM (Gratuito - Mais Técnico)**
```bash
# Via App Store ou Homebrew
brew install utm

# Ou baixar em https://mac.getutm.app/
```

#### 0.5.3 - Obter ISO do Ubuntu 24.04 LTS

```bash
# No MacBook, baixar ISO
cd ~/Linux-Admin-Project/

# Download Ubuntu Server 24.04 LTS para arm64 (Apple Silicon)
curl -o ubuntu-24.04-live-server-arm64.iso \
  https://releases.ubuntu.com/24.04/ubuntu-24.04-live-server-arm64.iso

# Verificar download (opcional)
ls -lh ubuntu-24.04-live-server-arm64.iso
```

#### 0.5.4 - Criar VM Ubuntu no Hypervisor

**Usando Parallels Desktop:**
```bash
# Parallels tem wizard, mas command line também funciona
# Configurações recomendadas:
# - CPU: 4 cores (do MacBook)
# - RAM: 4-8 GB (dependendo do seu MacBook)
# - Disk: 50 GB (suficiente para testes)
# - Network: Bridged (para estar na mesma LAN do MacBook)
# - ISO: ubuntu-24.04-live-server-arm64.iso
```

**Usando VMware Fusion:**
```bash
# File → New → Create a new virtual machine
# Selecionar ISO do Ubuntu
# Configurações:
# - CPUs: 4
# - Memory: 4-8 GB
# - Disk: 50 GB
# - Network: Bridged (essencial para SSH/RDP)
```

**Usando UTM:**
```bash
# Mais técnico, seguir documentação
# https://docs.getutm.app/guides/ubuntu/
# Configurações similares (4 CPU, 8 GB RAM, 50 GB Disk, Bridged)
```

#### 0.5.5 - Instalar Ubuntu 24.04 LTS na VM

```bash
# Na VM, durante instalação:
# 1. Keyboard layout: Português (Brazil) ou seu layout
# 2. Installation type: Server (não GUI para ser leve)
# 3. Network: Configurar DHCP ou IP estático 192.168.0.100
# 4. SSH Server: ✅ INSTALAR (importante!)
# 5. Username: 'vagrant' ou 'ubuntu' (simples para testes)
# 6. Password: Algo como 'ubuntu123' (será usar para testes)
# 7. Allow SSH password auth: ✅ SIM (para testes iniciais)

# Após instalação, rebootar
```

#### 0.5.6 - Configurar Rede da VM

**Objetivo:** VM acessível do MacBook via SSH/RDP

```bash
# Na VM Ubuntu
ip addr show  # Anotar o IP (ex: 192.168.0.100)

# No MacBook, testar conectividade
ping 192.168.0.100
ssh ubuntu@192.168.0.100  # Usar senha temporária
```

**Se não conseguir ping:**
```bash
# Verificar rede da VM em Parallels/VMware settings
# Garantir que está em "Bridge Mode" (não NAT)
# Bridge = VM tem IP na mesma rede que MacBook (192.168.0.x)
```

#### 0.5.7 - Preparar VM para Testes (Setup Rápido)

```bash
# Na VM, como root (sudo -i)

# 1. Atualizar sistema
sudo apt update && sudo apt upgrade -y

# 2. Instalar ferramentas básicas
sudo apt install -y curl wget git nano vim net-tools

# 3. Criar usuário admin (sem senha sudoers - para testes)
sudo useradd -m -G sudo -s /bin/bash admin_teste
sudo passwd admin_teste  # Definir senha

# 4. Criar usuário adolescente (sem privilégios)
sudo useradd -m -s /bin/bash adolescente
sudo passwd adolescente

# 5. Permitir SSH com senha (temporário - será desabilitado)
# Já deve estar habilitado, mas confirmar:
sudo nano /etc/ssh/sshd_config
# Procurar por: PasswordAuthentication yes
# Se não existir, adicionar
sudo systemctl restart ssh

# Pronto! VM está pronta para os testes
```

#### 0.5.8 - Snapshot da VM (Backup de Segurança)

```bash
# IMPORTANTE: Criar snapshot antes de executar Fases 1-6
# Assim pode voltar para estado limpo se algo dar errado

# Em Parallels Desktop:
# VM → Snapshots → Take Snapshot → "Ubuntu-24.04-Clean"

# Em VMware Fusion:
# VM → Snapshots → Take Snapshot → "Ubuntu-24.04-Clean"

# Em UTM:
# Edit → Snapshots → Create Snapshot
```

#### 0.5.9 - Checklist Fase 0.5

- [ ] Hypervisor instalado (Parallels/VMware/UTM)
- [ ] ISO Ubuntu 24.04 LTS arm64 baixada
- [ ] VM criada com 4 CPU, 8 GB RAM, 50 GB Disk
- [ ] Ubuntu 24.04 LTS instalado na VM
- [ ] SSH server instalado e funcionando na VM
- [ ] IP da VM anotado: `192.168.0.__________`
- [ ] Conectar via SSH do MacBook bem-sucedido
- [ ] Contas criadas: admin_teste + adolescente
- [ ] Snapshot "Ubuntu-24.04-Clean" criado
- [ ] VM pronta para começar Fase 1

---

### FASE 1: GERENCIAMENTO DE CONTAS E POLÍTICA DE PRIVILÉGIOS
**Duração Estimada:** 1-2 horas  
**Local:** Ubuntu (execução remota do MacBook via SSH)

#### 1.1 - Criação de Contas no Ubuntu
- [ ] Acesso root/sudo ao Ubuntu (inicial via teclado)
- [ ] Criar conta admin: `sudo useradd -m -G sudo -s /bin/bash admin_seu_nome`
- [ ] Definir senha admin: `sudo passwd admin_seu_nome`
- [ ] Criar conta adolescente: `sudo useradd -m -s /bin/bash -c "Adolescente" teen_user`
- [ ] Definir senha teen_user: `sudo passwd teen_user`
- [ ] Verificar criação: `cat /etc/passwd | grep -E 'admin_|teen_'`

#### 1.2 - Configuração de Sudoers
- [ ] Remover teen_user de sudo: Verificar `/etc/sudoers.d/`
- [ ] Confirmar admin_seu_nome em sudo: `groups admin_seu_nome`
- [ ] Bloquear acesso do teen_user a comandos críticos
  - Editar `/etc/sudoers.d/teen_restrictions`:
    ```
    teen_user ALL=(ALL) !ALL
    # Isso explicitamente nega teen_user de qualquer comando sudo
    ```

#### 1.3 - Proteção de Arquivos Críticos
- [ ] Remover leitura do teen_user em arquivos de config:
  ```bash
  sudo chmod 700 /etc/sudoers.d/
  sudo chmod 700 /etc/shadow
  sudo chmod 700 /etc/passwd (modificar com cuidado)
  sudo chmod 700 /boot/
  ```
- [ ] Proteger arquivos de auditoria: `sudo chmod 640 /var/log/audit/audit.log`
- [ ] Bloquear modificação de permissões pelo teen_user

#### 1.4 - Verificação de Acesso (MacBook)
- [ ] Conectar via SSH como admin: `ssh admin_seu_nome@ubuntu-ip`
- [ ] Verificar que teen_user NÃO pode fazer sudo
- [ ] Documentar configuração em `~/Linux-Admin-Project/docs/fase1-contas.md`

---

### FASE 2: CONTROLE DE CONTEÚDO E MONITORAMENTO DE SITES (DNS SEGURO)
**Duração Estimada:** 1-2 horas  
**Local:** Ubuntu

#### 2.1 - Configuração de DNS Seguro no Netplan
- [ ] Identificar arquivo Netplan: `ls /etc/netplan/`
- [ ] Backup do arquivo original: `sudo cp /etc/netplan/01-netcfg.yaml /etc/netplan/01-netcfg.yaml.backup`
- [ ] Editar Netplan para forçar DNS (CleanBrowsing ou OpenDNS):
  ```yaml
  network:
    version: 2
    renderer: networkd
    ethernets:
      eth0:  # ou seu adaptador
        dhcp4: true
        nameservers:
          addresses: [185.228.169.133, 185.228.168.133]  # CleanBrowsing Family
  ```
- [ ] Aplicar mudanças: `sudo netplan apply`
- [ ] Verificar DNS ativo: `resolvectl status` ou `cat /etc/resolv.conf`

#### 2.2 - Proteção contra Bypass de DNS
- [ ] Bloquear permissões de escrita no `/etc/resolv.conf`:
  ```bash
  sudo chattr +i /etc/resolv.conf  # i = imutável
  ```
- [ ] Verificar imutabilidade: `lsattr /etc/resolv.conf`
- [ ] Remover permissão teen_user de alterar rede:
  ```bash
  sudo usermod -G "" teen_user  # teen_user sem grupos especiais
  ```

#### 2.3 - Bloquear Ferramentas de Bypass
- [ ] Restringir acesso a ferramentas de VPN/proxy:
  ```bash
  sudo chmod 000 /usr/bin/curl  # ou symlink para versão controlada
  sudo chmod 000 /usr/bin/wget
  sudo chmod 000 /usr/bin/openssl (com cuidado)
  ```
  - OU: criar whitelist em AppArmor/SELinux

- [ ] Monitorar tentativas de download: Log em auditd (Fase 3)

#### 2.4 - Teste de Configuração (MacBook)
- [ ] SSH para Ubuntu como teen_user
- [ ] Tentar alterar DNS: `sudo vi /etc/resolv.conf` → deve falhar
- [ ] Tentar usar curl/wget: deve falhar ou ser logged
- [ ] Verificar que navegação web ainda funciona através do DNS forçado

---

### FASE 3: AUDITORIA DE SISTEMA E LOGS (AUDITD + ZEEK)
**Duração Estimada:** 2-3 horas  
**Local:** Ubuntu

#### 3.1 - Instalação do Auditd
- [ ] Verificar se auditd já está instalado: `sudo systemctl status auditd`
- [ ] Se não, instalar:
  ```bash
  sudo apt update
  sudo apt install -y auditd audispd-plugins
  sudo systemctl enable auditd
  sudo systemctl start auditd
  ```

#### 3.2 - Configuração de Regras de Auditoria
- [ ] Editar `/etc/audit/rules.d/audit.rules`:
  ```bash
  # Registrar todas as execuções (execve)
  -a always,exit -F arch=b64 -S execve -k session_commands
  
  # Registrar mudanças em /etc/
  -w /etc/ -p wa -k system_config_changes
  
  # Registrar tentativas de sudo
  -w /etc/sudoers -p wa -k sudoers_changes
  -w /var/log/auth.log -p wa -k auth_log_changes
  
  # Registrar login/logout
  -a always,exit -F arch=b64 -S sethostname,setdomainname -k network_config
  ```

- [ ] Recarregar regras: `sudo augenrules --load`
- [ ] Reiniciar auditd: `sudo systemctl restart auditd`

#### 3.3 - Verificação de Logs do Auditd
- [ ] Confirmar logging está ativo: `sudo tail -f /var/log/audit/audit.log`
- [ ] Executar comando e verificar log: `ausearch -k session_commands | head -20`
- [ ] Exemplo de busca por usuário:
  ```bash
  sudo ausearch -ua teen_user -m execve
  ```

#### 3.4 - Instalação do Zeek (para análise de tráfego)
- [ ] Instalar Zeek (antigo Bro):
  ```bash
  sudo apt install -y zeek
  sudo systemctl enable zeek
  sudo systemctl start zeek
  ```

- [ ] Configurar Zeek para monitorar interface LAN:
  ```bash
  sudo vi /opt/zeek/etc/node.cfg
  # Adicionar: interface=eth0 (seu adaptador)
  sudo /opt/zeek/bin/zeekctl deploy
  ```

#### 3.5 - Análise de Logs do Zeek
- [ ] Logs de conexão: `tail -f /opt/zeek/logs/current/conn.log`
- [ ] Logs de DNS: `tail -f /opt/zeek/logs/current/dns.log`
- [ ] Exemplo de filtro (sites visitados):
  ```bash
  zeek-cut query < /opt/zeek/logs/current/dns.log | sort | uniq -c | sort -rn
  ```

#### 3.6 - Centralização de Logs no MacBook (Opcional)
- [ ] Configurar syslog remoto do Ubuntu para MacBook
- [ ] Usar rsyslog: `sudo apt install rsyslog`
- [ ] Editar `/etc/rsyslog.conf` para enviar logs via TCP/UDP
- [ ] MacBook receber logs em `/var/log/remote/`

---

### FASE 4: ACESSO REMOTO SEGURO VIA SSH E RDP
**Duração Estimada:** 2-3 horas  
**Executado:** MacBook → Ubuntu

#### 4.1 - Configuração SSH no Ubuntu
- [ ] Verificar SSH instalado: `sudo systemctl status ssh`
- [ ] Se não, instalar: `sudo apt install -y openssh-server openssh-client`

- [ ] Backup da config: `sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.backup`

- [ ] Editar `/etc/ssh/sshd_config`:
  ```bash
  # Mudar porta
  Port 2222  # ou outra > 1024
  
  # Desativar login por senha
  PasswordAuthentication no
  PubkeyAuthentication yes
  
  # Apenas para admin
  AllowUsers admin_seu_nome
  
  # Reforço de segurança
  PermitRootLogin no
  X11Forwarding yes  # para suporte a apps gráficos
  ```

- [ ] Validar sintaxe: `sudo sshd -t`
- [ ] Reiniciar SSH: `sudo systemctl restart ssh`

#### 4.2 - Geração de Chaves SSH no MacBook
- [ ] Criar par de chaves:
  ```bash
  ssh-keygen -t rsa -b 4096 -f ~/.ssh/ubuntu_admin_key -C "admin@macbook"
  # Deixar passphrase vazia OU usar senha (mais seguro)
  ```

- [ ] Verificar geração:
  ```bash
  ls -la ~/.ssh/ubuntu_admin_key*
  ```

- [ ] Salvar chaves no projeto:
  ```bash
  cp ~/.ssh/ubuntu_admin_key ~/Linux-Admin-Project/ssh-keys/
  cp ~/.ssh/ubuntu_admin_key.pub ~/Linux-Admin-Project/ssh-keys/
  chmod 600 ~/Linux-Admin-Project/ssh-keys/ubuntu_admin_key
  ```

#### 4.3 - Transferência de Chave Pública para Ubuntu
**Opção A: Via arquivo (mais segura inicialmente)**
- [ ] No MacBook, copiar via SCP:
  ```bash
  # Usando porta 22 (antes de mudar para 2222)
  scp -P 22 ~/.ssh/ubuntu_admin_key.pub admin_seu_nome@ubuntu-ip:~/.ssh/uploaded_key.pub
  ssh admin_seu_nome@ubuntu-ip "cat ~/.ssh/uploaded_key.pub >> ~/.ssh/authorized_keys && chmod 600 ~/.ssh/authorized_keys"
  ```

**Opção B: Usando ssh-copy-id (mais simples)**
- [ ] Se disponível:
  ```bash
  ssh-copy-id -i ~/.ssh/ubuntu_admin_key.pub -p 22 admin_seu_nome@ubuntu-ip
  ```

#### 4.4 - Teste de Acesso SSH (MacBook)
- [ ] Criar alias no `~/.ssh/config`:
  ```
  Host ubuntu-admin
    HostName ubuntu-ip
    User admin_seu_nome
    Port 2222
    IdentityFile ~/.ssh/ubuntu_admin_key
    IdentitiesOnly yes
  ```

- [ ] Conectar:
  ```bash
  ssh ubuntu-admin
  # Não deve pedir senha, apenas passphrase se houver
  ```

#### 4.5 - Configuração RDP no Ubuntu
- [ ] Instalar servidor RDP:
  ```bash
  sudo apt install -y xrdp xorgxrdp
  sudo systemctl enable xrdp
  sudo systemctl start xrdp
  ```

- [ ] Verificar portas: `sudo netstat -tulpn | grep :3389`

- [ ] Configurar firewall (se houver):
  ```bash
  sudo ufw allow 3389/tcp
  ```

#### 4.6 - Configuração RDP no MacBook
- [ ] Instalar Microsoft Remote Desktop (App Store ou Homebrew)
- [ ] Abrir e criar nova conexão:
  - Host: `ubuntu-ip:3389`
  - Usuário: `admin_seu_nome`
  - Senha: senha do admin
- [ ] Testar conexão

---

### FASE 5: ACESSO REMOTO EXTRAREDE COM RUSTDESK (Mesmo ISP/Rede)
**Duração Estimada:** 1-2 horas  
**Executado:** MacBook ↔ Ubuntu (qualquer rede)
**Limitações:** Ambos conectados ao mesmo ISP ou rede pública

---

### FASE 6: CONEXÃO REMOTA PERMANENTE (Redes Diferentes - CENÁRIO AVANÇADO)
**Duração Estimada:** 3-4 horas  
**Cenário:** Ubuntu em outra casa, outra rede, outra ISP  
**Objetivo:** Conexão sempre ativa, confiável e segura

#### 6.1 - ANÁLISE DO PROBLEMA

**Desafios de Múltiplas Redes:**
- [ ] **IPs Dinâmicos:** Ambas máquinas podem ter IPs que mudam
- [ ] **NAT/Firewall:** Roteadores podem bloquear conexões de entrada
- [ ] **Redes Separadas:** Sem acesso ao mesmo gateway/LAN
- [ ] **Conectividade Intermitente:** Wi-Fi instável pode desconectar
- [ ] **Segurança:** Tráfego atravessando internet pública = criptografia necessária

**Soluções Disponíveis:**
1. **RustDesk com Relay Privado** - P2P com fallback em servidor central
2. **WireGuard VPN** - Túnel VPN leve, moderno e seguro
3. **OpenVPN** - VPN tradicional, mais maduro
4. **SSH Reverse Tunnel** - Túnel SSH permanente com reconnect automático
5. **Tailscale** - Mesh VPN, zero-config, mais simples

**Recomendação:** Usar **combinação de RustDesk + WireGuard** ou **RustDesk + SSH Reverse Tunnel**

---

#### 6.2 - SOLUÇÃO 1: RUSTDESK COM RELAY PRIVADO (RECOMENDADO - Mais Simples)

**Vantagens:**
- ✅ Já instalado (Fase 5)
- ✅ Funciona automático
- ✅ Criptografia de ponta a ponta
- ✅ Suporta P2P e relay fallback
- ✅ Controle remoto visual + transferência de arquivos

**Desvantagens:**
- ❌ Depende de servidor relay público ou privado
- ❌ Menos transparente (não é tunelamento de rede)
- ❌ Apenas para controle remoto, não para SSH direto

##### 6.2.1 - Configurar Relay Privado RustDesk (Opcional - Para Máxima Privacidade)

**Opção A: Usar Relay Público RustDesk (Mais Simples)**
- Já funciona automático
- RustDesk fornece relay server gratuito
- Ir para seção 6.2.2

**Opção B: Hospedar Relay Privado (Requer VPS/Servidor)**
- [ ] Adquirir VPS Linux (DigitalOcean, Linode, etc.)
- [ ] Instalar RustDesk Server:
  ```bash
  # No servidor
  wget https://github.com/rustdesk/rustdesk-server/releases/download/[VERSION]/rustdesk-server-linux-x64.tar.gz
  tar xzf rustdesk-server-linux-x64.tar.gz
  cd rustdesk-server-linux-x64
  ./hbbr  # Relay server
  ./hs    # Signal server (em outro terminal ou bg)
  ```

- [ ] Configurar certificados SSL (para segurança)
- [ ] Abrir firewall do servidor (portas 21115, 21116, 21117, 21118, 21119)
- [ ] Anotar IP/hostname do servidor relay: `______________`

##### 6.2.2 - Configurar RustDesk para Reconnect Automático

**No Ubuntu:**
- [ ] Editar `/root/.config/rustdesk/config.toml` (ou via GUI)
- [ ] Adicionar opção de auto-start:
  ```bash
  sudo systemctl enable rustdesk
  sudo systemctl start rustdesk
  ```

- [ ] Configurar para iniciar ao boot:
  ```bash
  # Criar serviço systemd
  sudo tee /etc/systemd/system/rustdesk.service > /dev/null <<EOF
  [Unit]
  Description=RustDesk Remote Desktop
  After=network.target
  
  [Service]
  Type=simple
  ExecStart=/usr/bin/rustdesk --connect [ID_MACBOOK]
  Restart=always
  RestartSec=10
  
  [Install]
  WantedBy=multi-user.target
  EOF
  
  sudo systemctl daemon-reload
  sudo systemctl enable rustdesk
  sudo systemctl start rustdesk
  ```

**No MacBook:**
- [ ] RustDesk já será iniciado (manual ou via agendador)
- [ ] Configurar para conectar automático ao iniciar (Settings → Auto Launch)

##### 6.2.3 - Monitoramento de Conexão RustDesk

```bash
# Verificar se RustDesk está rodando (Ubuntu)
sudo systemctl status rustdesk
ps aux | grep rustdesk

# Ver logs de conexão
journalctl -u rustdesk -f

# Testar conectividade (MacBook)
rustdesk --session [ID_UBUNTU]
```

---

#### 6.3 - SOLUÇÃO 2: SSH REVERSE TUNNEL (Mais Seguro + Acesso Terminal Direto)

**Vantagens:**
- ✅ Reconecta automaticamente
- ✅ Apenas 1 porta aberta no MacBook (porta SSH)
- ✅ Acesso terminal direto sem RustDesk
- ✅ Tunelamento de qualquer serviço (RDP, HTTP, etc)
- ✅ Mais leve que VPN

**Desvantagens:**
- ❌ Requer configuração mais complexa
- ❌ Depende de daemon rodando constantemente
- ❌ Requer chave SSH sem passphrase (ou usar ssh-agent)

##### 6.3.1 - Configurar SSH Reverse Tunnel (Ubuntu → MacBook)

**Objetivo:** Ubuntu inicia conexão SSH para MacBook e abre um túnel reverso

**Passo 1: Gerar chaves SSH para o daemon**
```bash
# No Ubuntu (como root)
sudo mkdir -p /root/.ssh
sudo ssh-keygen -t ed25519 -f /root/.ssh/tunnel_key -N "" -C "ubuntu-tunnel"
# -N "" = sem passphrase (necessário para automação)

# Ver chave pública
cat /root/.ssh/tunnel_key.pub
```

**Passo 2: Autorizar chave no MacBook**
```bash
# No MacBook
mkdir -p ~/.ssh
echo "ssh-ed25519 AAAA... ubuntu-tunnel@ubuntu" >> ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys

# Copiar também da Ubuntu para arquivo local (segurança)
scp admin_seu_nome@ubuntu:/root/.ssh/tunnel_key.pub ~/Linux-Admin-Project/ssh-keys/ubuntu_tunnel_key.pub
```

**Passo 3: Configurar Reverse Tunnel Permanente (Ubuntu)**

Criar script no Ubuntu que mantém túnel ativo:
```bash
# No Ubuntu, criar: /usr/local/bin/ssh-tunnel-keeper.sh
sudo tee /usr/local/bin/ssh-tunnel-keeper.sh > /dev/null <<'EOF'
#!/bin/bash

# Configurações
MAC_USER="seu_usuario_mac"
MAC_IP="seu_macbook_ip_publico_ou_dyndns"
MAC_SSH_PORT="2222"
TUNNEL_PORT="2223"  # Porta local do Ubuntu que forward para SSH do Mac
LOG_FILE="/var/log/ssh-tunnel-keeper.log"
PID_FILE="/var/run/ssh-tunnel-keeper.pid"

# Função para iniciar tunnel
start_tunnel() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] Iniciando SSH reverse tunnel..." >> $LOG_FILE
    
    # Matar qualquer instância anterior
    kill $(cat $PID_FILE 2>/dev/null) 2>/dev/null
    
    # Iniciar novo tunnel
    # -R: Reverse port forward
    # -N: Sem shell remoto
    # -f: Background
    # -i: Arquivo de chave
    ssh -R $TUNNEL_PORT:localhost:22 \
        -i /root/.ssh/tunnel_key \
        -N -f \
        -o StrictHostKeyChecking=no \
        -o UserKnownHostsFile=/dev/null \
        -o ConnectTimeout=10 \
        -o ServerAliveInterval=60 \
        -o ServerAliveCountMax=3 \
        -o ExitOnForwardFailure=yes \
        $MAC_USER@$MAC_IP -p $MAC_SSH_PORT
    
    local pid=$!
    echo $pid > $PID_FILE
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] Tunnel iniciado com PID $pid" >> $LOG_FILE
}

# Função para verificar e reconectar
check_tunnel() {
    local pid=$(cat $PID_FILE 2>/dev/null)
    
    if [ -z "$pid" ] || ! kill -0 $pid 2>/dev/null; then
        echo "[$(date '+%Y-%m-%d %H:%M:%S')] ⚠️ Tunnel inativo! Reconectando..." >> $LOG_FILE
        start_tunnel
    else
        echo "[$(date '+%Y-%m-%d %H:%M:%S')] ✅ Tunnel ativo (PID $pid)" >> $LOG_FILE
    fi
}

# Loop infinito de verificação
while true; do
    check_tunnel
    sleep 30  # Verificar a cada 30 segundos
done
EOF

sudo chmod +x /usr/local/bin/ssh-tunnel-keeper.sh
```

**Passo 4: Criar Serviço SystemD para SSH Tunnel (Ubuntu)**
```bash
sudo tee /etc/systemd/system/ssh-tunnel-keeper.service > /dev/null <<EOF
[Unit]
Description=SSH Reverse Tunnel Keeper (Ubuntu -> MacBook)
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

sudo systemctl daemon-reload
sudo systemctl enable ssh-tunnel-keeper
sudo systemctl start ssh-tunnel-keeper
```

**Passo 5: Ativar SSH Listening no MacBook**

Garantir que MacBook aceita conexões SSH:
```bash
# No MacBook, verificar SSH ativo
sudo systemctl status ssh  # Linux
sudo launchctl list | grep ssh  # macOS

# Se não estiver ativo:
sudo launchctl start com.openssh.sshd  # macOS
```

**Passo 6: Usar o Reverse Tunnel (MacBook)**

Para conectar ao Ubuntu via tunnel:
```bash
# Do MacBook, conectar ao Ubuntu através do túnel
ssh -p 2223 admin_seu_nome@localhost

# Ou criar alias em ~/.ssh/config
Host ubuntu-via-tunnel
    HostName localhost
    Port 2223
    User admin_seu_nome
    IdentityFile ~/.ssh/ubuntu_admin_key
```

---

#### 6.4 - SOLUÇÃO 3: WIREGUARD VPN (Para Acesso Total de Rede)

**Vantagens:**
- ✅ Criptografia moderna (Curve25519)
- ✅ Muito mais leve que OpenVPN
- ✅ Acesso de rede completo (não apenas portas específicas)
- ✅ Suporta múltiplos clientes
- ✅ Performático

**Desvantagens:**
- ❌ Requer configuração mais complexa
- ❌ Requer VPS/servidor central (ou P2P peer-to-peer)
- ❌ Mais técnico que RustDesk

##### 6.4.1 - Instalar WireGuard no Ubuntu

```bash
# No Ubuntu
sudo apt update
sudo apt install -y wireguard wireguard-tools

# Gerar chaves
umask 077
wg genkey | tee /tmp/private.key | wg pubkey > /tmp/public.key

# Visualizar chaves
cat /tmp/private.key
cat /tmp/public.key
```

##### 6.4.2 - Configurar WireGuard no Ubuntu

```bash
# Criar arquivo de configuração
sudo tee /etc/wireguard/wg0.conf > /dev/null <<EOF
[Interface]
PrivateKey = $(cat /tmp/private.key)
Address = 10.0.0.1/24
ListenPort = 51820

# Ativar forwarding
PostUp = iptables -A FORWARD -i wg0 -j ACCEPT; iptables -A FORWARD -o wg0 -j ACCEPT; iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
PostDown = iptables -D FORWARD -i wg0 -j ACCEPT; iptables -D FORWARD -o wg0 -j ACCEPT; iptables -t nat -D POSTROUTING -o eth0 -j MASQUERADE

# Peer MacBook
[Peer]
PublicKey = <CHAVE_PUBLICA_MACBOOK>
AllowedIPs = 10.0.0.2/32
EOF

sudo chmod 600 /etc/wireguard/wg0.conf
```

##### 6.4.3 - Instalar WireGuard no MacBook

```bash
# Via Homebrew
brew install wireguard-tools

# Ou via App Store: WireGuard (aplicativo oficial)
```

##### 6.4.4 - Gerar Chave do MacBook e Configurar Peer

```bash
# No MacBook
umask 077
wg genkey | tee /tmp/macbook_private.key | wg pubkey > /tmp/macbook_public.key

# Copiar chave pública do MacBook para Ubuntu
# (adicionar como Peer na configuração do Ubuntu)
```

---

#### 6.5 - SOLUÇÃO 4: DINÂMICO DNS (Para Quando IP Muda)

**Problema:** Se Ubuntu ou MacBook tiverem IP dinâmico do ISP, endereço muda

**Solução:** Usar Dynamic DNS (DDNS)

##### 6.5.1 - Configurar Dynamic DNS no Ubuntu

```bash
# Instalar cliente DDNS
sudo apt install -y ddclient

# Configurar para seu serviço DDNS (ex: No-IP, DynDNS, Cloudflare)
sudo nano /etc/ddclient.conf

# Exemplo para No-IP:
protocol=noip
use=web
web=dynamicupdate.no-ip.com/nic/update
login=seu_usuario_no_ip
password=sua_senha_no_ip
ubuntu.no-ip.biz

# Ativar serviço
sudo systemctl enable ddclient
sudo systemctl start ddclient
```

##### 6.5.2 - Usar DDNS em Configurações SSH

```bash
# Em ~/.ssh/config (MacBook)
Host ubuntu-remote
    HostName ubuntu.no-ip.biz  # Em vez de IP
    Port 2222
    User admin_seu_nome
    IdentityFile ~/.ssh/ubuntu_admin_key
```

---

#### 6.6 - MONITORAMENTO E HEARTBEAT

Para garantir que conexão sempre está ativa:

##### 6.6.1 - Script de Verificação de Conectividade (MacBook)

```bash
# Criar: ~/Linux-Admin-Project/scripts/check-connection.sh
#!/bin/bash

UBUNTU_IP="seu_ubuntu_ip_ou_ddns"
UBUNTU_PORT="2222"
LOG_FILE="$HOME/Linux-Admin-Project/logs/connection-monitor.log"

check_ssh() {
    timeout 5 ssh -o ConnectTimeout=5 -p $UBUNTU_PORT admin_seu_nome@$UBUNTU_IP "echo 'SSH OK'" > /dev/null 2>&1
    return $?
}

check_rustdesk() {
    # Verificar se RustDesk está respondendo
    if pgrep -x "RustDesk" > /dev/null; then
        return 0
    fi
    return 1
}

log_status() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] SSH: $1 | RustDesk: $2" >> $LOG_FILE
}

if check_ssh; then
    SSH_STATUS="✅ OK"
else
    SSH_STATUS="❌ FALHA"
fi

if check_rustdesk; then
    RD_STATUS="✅ OK"
else
    RD_STATUS="❌ FALHA"
fi

log_status "$SSH_STATUS" "$RD_STATUS"

# Alertar se ambas falharem
if [ "$SSH_STATUS" = "❌ FALHA" ] && [ "$RD_STATUS" = "❌ FALHA" ]; then
    echo "⚠️ ALERTA: Ambas conexões indisponíveis!" >> $LOG_FILE
    # Opcional: enviar notificação
    # osascript -e 'display notification "Conexão Ubuntu indisponível" with title "Alerta Linux Admin"'
fi
```

##### 6.6.2 - Agendar Verificação Periódica (MacBook)

```bash
# Criar LaunchAgent para rodar a cada 5 minutos
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
    <integer>300</integer>  <!-- 300 segundos = 5 minutos -->
    <key>StandardOutPath</key>
    <string>$HOME/Linux-Admin-Project/logs/monitor-stdout.log</string>
    <key>StandardErrorPath</key>
    <string>$HOME/Linux-Admin-Project/logs/monitor-stderr.log</string>
</dict>
</plist>
EOF

# Carregar serviço
launchctl load ~/Library/LaunchAgents/com.local.connection-monitor.plist

# Verificar se está ativo
launchctl list | grep connection-monitor
```

---

#### 6.7 - SEGURANÇA EM CONEXÕES DE LONGA DISTÂNCIA

**Considerações importantes:**

- [ ] **Firewall do ISP:** Verificar se bloqueará portas (use porta >1024)
- [ ] **Certificados SSL:** Para RDP e VPN, usar certificados válidos
- [ ] **Chaves sem Passphrase:** Para automação, mas com permissões 600
- [ ] **Logs Auditados:** Registrar todas as tentativas de conexão remota
- [ ] **Backup de Conectividade:** Ter múltiplas formas de acesso (SSH + RustDesk + VPN)
- [ ] **Criptografia de Transporte:** Sempre usar SSH/RDP/VPN, nunca telnet/HTTP
- [ ] **Rate Limiting:** Proteger contra brute-force:
  ```bash
  # No Ubuntu
  sudo apt install fail2ban
  sudo systemctl enable fail2ban
  ```

---

#### 6.8 - PLANO DE AÇÃO PARA CONEXÃO REMOTA PERMANENTE

**Recomendação de Stack:**

```
┌─────────────────────────────────────────────────────────────┐
│           ARQUITETURA DE CONEXÃO REMOTA PERMANENTE           │
├─────────────────────────────────────────────────────────────┤
│                                                               │
│  CAMADA 1: RustDesk (Principal)                              │
│  └─ Controle remoto visual + transferência de arquivos       │
│  └─ Auto-reconecta com relay fallback                        │
│  └─ Serviço systemd no Ubuntu                                │
│                                                               │
│  CAMADA 2: SSH Reverse Tunnel (Backup + Terminal Access)     │
│  └─ Acesso terminal direto                                   │
│  └─ Reconecta automático a cada 30 segundos                  │
│  └─ Daemon ssh-tunnel-keeper                                 │
│                                                               │
│  CAMADA 3: WireGuard VPN (Opcional - Acesso Total Rede)      │
│  └─ Se precisar de acesso VPN completo                       │
│  └─ Alternativa a VPN tradicional                            │
│                                                               │
│  CAMADA 4: Dynamic DNS (Se IP Dinâmico)                      │
│  └─ ubuntu.no-ip.biz ao invés de IP estático                 │
│  └─ Atualiza automaticamente quando IP muda                  │
│                                                               │
└─────────────────────────────────────────────────────────────┘
```

**Plano de Implementação:**

| Passo | Componente | Prioridade | Duração |
|-------|-----------|-----------|---------|
| 1 | RustDesk com auto-reconnect | 🔴 ALTA | 30min |
| 2 | SSH Reverse Tunnel | 🔴 ALTA | 1h |
| 3 | Monitoramento de conexão | 🟠 MÉDIA | 45min |
| 4 | Dynamic DNS (se necessário) | 🟡 BAIXA | 30min |
| 5 | WireGuard VPN (opcional) | 🟡 BAIXA | 2h |

---

#### 6.9 - CHECKLIST: CONEXÃO REMOTA PERMANENTE

- [ ] **RustDesk Configurado**
  - [ ] Serviço rodando no Ubuntu
  - [ ] Auto-start na inicialização
  - [ ] Senha permanente definida
  - [ ] Testado com IP mudando (simulado)

- [ ] **SSH Reverse Tunnel**
  - [ ] Chaves geradas (sem passphrase)
  - [ ] Autorização no MacBook
  - [ ] Script ssh-tunnel-keeper.sh ativo
  - [ ] Serviço systemd testado
  - [ ] Reconexão automática funcionando

- [ ] **Dynamic DNS (Se aplicável)**
  - [ ] Cliente DDNS instalado
  - [ ] Conta no serviço DDNS criada
  - [ ] hostname atualizado automaticamente
  - [ ] Testado com alteração manual de IP

- [ ] **Monitoramento**
  - [ ] Script de verificação criado
  - [ ] LaunchAgent configurado no MacBook
  - [ ] Logs sendo registrados
  - [ ] Alertas funcionando

- [ ] **Segurança**
  - [ ] Fail2ban instalado no Ubuntu
  - [ ] SSH com chaves apenas (sem senha)
  - [ ] Auditoria de conexões remotas ativa
  - [ ] Certificados atualizados

- [ ] **Testes Finais**
  - [ ] Desligar Wi-Fi e reconectar (simulando mudança de rede)
  - [ ] Testar controle remoto durante transição
  - [ ] Verificar logs de reconexão
  - [ ] Confirmar que monitoramento está alertando

---

#### 5.1 - Decisão de Infraestrutura
- [ ] **Opção A:** Servidor Relay RustDesk Público (mais fácil)
  - Usar servidores públicos da RustDesk
  - Rápido de configurar
  - Depende de servidor de terceiros

- [ ] **Opção B:** Servidor Relay RustDesk Privado (mais seguro)
  - Hospedar próprio servidor relay
  - Controle total
  - Requer servidor/VPS

**Recomendação:** Usar Opção A para início

#### 5.2 - Instalação do RustDesk no Ubuntu
- [ ] Baixar: https://rustdesk.com/
  ```bash
  wget https://github.com/rustdesk/rustdesk/releases/download/[VERSION]/rustdesk-[VERSION].deb
  sudo apt install ./rustdesk-[VERSION].deb
  ```

- [ ] Executar RustDesk:
  ```bash
  rustdesk &  # ou via GUI
  ```

- [ ] Obter ID e senha temporária na interface
- [ ] Notar o ID único gerado: `rustdesk-[ID]`

#### 5.3 - Instalação do RustDesk no MacBook
- [ ] Baixar: https://rustdesk.com/download/
- [ ] Instalar via Homebrew:
  ```bash
  brew install rustdesk
  ```

- [ ] Abrir e inserir ID do Ubuntu
- [ ] Conectar

#### 5.4 - Configuração de Segurança RustDesk
- [ ] No Ubuntu, definir senha de acesso permanente:
  - Settings → Security → Set Password
  
- [ ] No MacBook, configurar para conectar com a senha

#### 5.5 - Teste de Conectividade
- [ ] Testar controle remoto via RustDesk
- [ ] Testar transferência de arquivos
- [ ] Testar em redes diferentes (Wi-Fi diferentes)

---

## 🗂️ ESTRUTURA DE ARQUIVOS DO PROJETO

```
~/Linux-Admin-Project/
├── planejamento.md                    # Este arquivo
├── docs/
│   ├── fase0-requisitos.md
│   ├── fase1-contas.md
│   ├── fase2-dns.md
│   ├── fase3-auditoria.md
│   ├── fase4-ssh-rdp.md
│   ├── fase5-rustdesk.md
│   └── referencia-comandos.md
├── scripts/
│   ├── setup-ubuntu-admin.sh          # Criar contas (rodar em Ubuntu)
│   ├── setup-auditd.sh                # Configurar auditd (rodar em Ubuntu)
│   ├── gen-ssh-keys.sh                # Gerar chaves SSH (rodar em MacBook)
│   ├── deploy-ssh-keys.sh             # Enviar chaves para Ubuntu
│   └── verify-security.sh             # Verificar configurações
├── configs/
│   ├── netplan-01-netcfg.yaml         # Config DNS
│   ├── sshd_config                    # Config SSH
│   ├── audit.rules                    # Regras auditd
│   └── node.cfg                       # Config Zeek
├── ssh-keys/
│   ├── ubuntu_admin_key               # Private key (CONFIDENCIAL)
│   └── ubuntu_admin_key.pub           # Public key
├── logs/
│   ├── audit-backup/
│   ├── zeek-backup/
│   └── connectivity-tests.log
└── CHANGELOG.md                       # Histórico de mudanças
```

---

## 📅 ROADMAP TEMPORAL

| Fase | Tarefa | Duração | Status | Local |
|------|--------|---------|--------|-------|
| 0 | Pré-requisitos MacBook | 2-4h | ⏳ Pendente | MacBook |
| **0.5** | **Criar + Preparar VM** | **2-3h** | **⏳ Pendente** | **MacBook (VM)** |
| 1-5 (VM) | **TESTES em VM** | **9-16h** | **⏳ Pendente** | **MacBook (VM)** |
| **Validação** | **Verificar todas fases** | **1-2h** | **⏳ Pendente** | **MacBook (VM)** |
| **Migração** | **Copiar para Máquina Oficial** | **1-2h** | **⏳ Pendente** | **Máquina Official** |
| 1-5 (Oficial) | Executar em máquina real | 9-16h | ⏳ Futuro | Máquina Oficial |
| 6 (Opcional) | Conexão Redes Diferentes | 3-4h | ⏳ Futuro | Máquina Oficial |

| Etapa | Duração Total | Status |
|------|---------------|--------|
| **Fase 0 + 0.5 (Preparação)** | **4-7h** | ⏳ Em Progresso |
| **Fases 1-5 (Testes em VM)** | **9-16h** | ⏳ Próximo |
| **Validação + Migração** | **2-4h** | ⏳ Depois |
| **TOTAL até Máquina Oficial** | **15-27h** | ⏳ |

**Estratégia:**
1. Fase 0 (MacBook): Preparar ambiente
2. Fase 0.5 (VM): Criar máquina de teste
3. Fases 1-5 (VM): Testar todas configurações
4. Validação (VM): Confirmar tudo funciona
5. Migração: Scripts para copiar para máquina oficial
6. Fases 1-5 (Oficial): Replicar em máquina real

---

## 🌍 COMPARAÇÃO DE CENÁRIOS

### Cenário 1: Mesma Casa / Mesma LAN (Fase 5)
```
                    ┌─────────────────────────────────────────┐
                    │         REDE LOCAL (192.168.0.x)        │
                    │                                         │
    ┌──────────────┐│  ┌──────────────┐   ┌──────────────┐   │
    │   MacBook    ││  │    Ubuntu    │   │  Roteador/  │   │
    │192.168.0.50  ││  │ 192.168.0.60 │   │    Gateway  │   │
    │ (Admin)      ││  │ (Adolescente)│   │             │   │
    └──────────────┘│  └──────────────┘   └──────────────┘   │
         │SSH│RDP│  │         │                               │
         └─────────┼─────────┘                                │
                    └─────────────────────────────────────────┘

Protocolos Disponíveis:
  ✅ SSH direto (porta 2222) - conexão local rápida
  ✅ RDP direto (porta 3389) - GUI local
  ✅ RustDesk P2P - sem servidor relay necessário
```

### Cenário 2: Outra Casa / Redes Diferentes (Fase 6)
```
┌──────────────────────────┐          INTERNET           ┌──────────────────────────┐
│     CASA 1 (MacBook)     │                             │  CASA 2 (Ubuntu)         │
│   ┌────────────────────┐ │                             │ ┌────────────────────┐  │
│   │   MacBook          │ │                             │ │   Ubuntu 24.04     │  │
│   │ 192.168.1.50       │ │         VPN Tunnel        │ │ 192.168.2.60       │  │
│   │ 54.232.189.113 (ext)                              │ │ 203.0.113.45 (ext) │  │
│   └────────────────────┘ │    ◄──── SSH Tunnel ────► │ │ Dynamic DNS:       │  │
│   ┌─────────────────┐    │    ◄──── RustDesk ─────► │ │ ubuntu.no-ip.biz   │  │
│   │  Wi-Fi ISP-A    │    │    ◄──── WireGuard ────► │ │ ┌────────────────┐ │  │
│   │ Roteador A      │    │                             │ │ Wi-Fi ISP-B    │ │  │
│   └─────────────────┘    │                             │ │ Roteador B     │ │  │
└──────────────────────────┘                             │ └────────────────┘ │  │
         │                                               │         │            │  │
         └───────────────────────────────────────────────┘─────────┘            │  │
                                                         └────────────────────────┘

Protocolos Necessários:
  ✅ RustDesk (Principal) - P2P com relay fallback
  ✅ SSH Reverse Tunnel - Reconecta automático
  ✅ WireGuard VPN (Opcional) - Para acesso total
  ✅ Dynamic DNS - Quando IP muda
```

### Cenário 3: Escalabilidade (Múltiplos Ubuntu)
```
                          MacBook (Admin Central)
                          192.168.1.50
                                │
                ┌───────────────┼───────────────┐
                │               │               │
         ┌──────────────┐  ┌──────────────┐  ┌──────────────┐
         │  Ubuntu #1   │  │  Ubuntu #2   │  │  Ubuntu #3   │
         │ Casa 1 (LAN) │  │ Casa 2 (WAN) │  │ Casa 3 (WAN) │
         │ 192.168.1.60 │  │ 203.0.113.45 │  │ 198.51.100.5 │
         └──────────────┘  └──────────────┘  └──────────────┘
              │SSH/RDP           │RustDesk         │RustDesk
              │ RDP             │+SSH Tunnel      │+SSH Tunnel
              │                 │+DDNS            │+DDNS
         Local LAN         Different ISP      Different ISP

Solução: Usar Ansible para automação centralizada
```

---

## 🔐 CONSIDERAÇÕES DE SEGURANÇA

### Durante Implementação
- [ ] Usar senhas fortes (16+ caracteres, misto)
- [ ] Gerar chaves SSH com pelo menos 4096 bits (ou Ed25519)
- [ ] Nunca compartilhar chaves privadas
- [ ] Fazer backup de chaves em local seguro
- [ ] Testar cada fase antes de passar para a próxima

### Proteção do Adolescente
- [ ] Remover acesso sudo completamente
- [ ] Bloquear instalação de pacotes: `sudo apt install` → rejeitar
- [ ] Bloquear acesso a ferramentas de rede: `sudo iptables` → rejeitar
- [ ] Auditar logs regularmente
- [ ] Revisar histórico de sites e comandos 1x semana

### Proteção da Administração (MacBook)
- [ ] Guardar chaves SSH em local protegido
- [ ] Usar passphrase nas chaves SSH
- [ ] Ativar 2FA se possível
- [ ] Fazer backup de chaves cryptadas
- [ ] Limpar histórico SSH periodicamente: `history -c`

---

## 🔄 COMPATIBILIDADE FUTURA (LINUX ADMIN)

Quando migrar a máquina administrativa do MacBook para Linux:

### Mudanças Necessárias
1. **Terminal:** Terminal.app → GNOME Terminal / Konsole
2. **SSH:** OpenSSH já instalado em Linux
3. **Remote Desktop:** Usar Remmina em vez de Microsoft Remote Desktop
4. **Ferramentas:** Mesmas ferramentas CLI funcionam em Linux
5. **RustDesk:** Versão Linux já suportada

### Transferência de Configuração
- [ ] Copiar chaves SSH:
  ```bash
  scp -r ~/Linux-Admin-Project/ novo-admin@novo-linux:~/
  ```
- [ ] Reconfigurar `~/.ssh/config` no novo Linux
- [ ] Reinstalar RustDesk em novo Linux
- [ ] Todos os comandos funcionarão sem mudanças

### Escalabilidade
- Se gerenciar **múltiplos Ubuntus** futuros:
  - Usar Ansible para automação
  - Criar playbooks YAML para cada fase
  - Centralizar logs em servidor ELK (Elasticsearch, Logstash, Kibana)
  - Configurar Nagios/Prometheus para monitoramento

---

## ✅ CHECKLIST DE CONCLUSÃO

### Fase 0 - PRÉ-REQUISITOS (STATUS: 2026-09-28)
- [x] OpenSSH 10.2p1 - JÁ INSTALADO
- [x] SSH tools (ssh, scp, sftp, ssh-keygen) - JÁ DISPONÍVEIS
- [x] Homebrew 7.0.4 - JÁ INSTALADO
- [x] Terminal.app - JÁ DISPONÍVEL
- [x] Git 2.50.1 - JÁ INSTALADO
- [x] Rede local (192.168.0.63) - JÁ CONFIGURADA
- [ ] **Microsoft Remote Desktop - INSTALAR: `brew install microsoft-remote-desktop`**
- [ ] **Diretórios criados: `mkdir -p ~/Linux-Admin-Project/{configs,scripts,logs,ssh-keys,docs,backups}`**

### Fase 0.5 - MÁQUINA VIRTUAL (PRÓXIMO PASSO)
- [ ] Hypervisor instalado (Parallels/VMware/UTM)
- [ ] ISO Ubuntu 24.04 LTS arm64 baixada
- [ ] VM criada com 4 CPU, 8 GB RAM, 50 GB Disk
- [ ] Ubuntu 24.04 LTS instalado na VM
- [ ] SSH server funcionando
- [ ] Contas criadas: admin_teste + adolescente
- [ ] Snapshot "Ubuntu-24.04-Clean" criado
- [ ] **VM IP anotado: `192.168.0._____`**

### Fases 1-5 (EM VM)
- [ ] Fase 1: Contas e privilégios (na VM)
- [ ] Fase 2: DNS seguro (na VM)
- [ ] Fase 3: Auditoria (na VM)
- [ ] Fase 4: SSH + RDP (na VM)
- [ ] Fase 5: RustDesk (na VM)
- [ ] Todos os testes passando (na VM)

### Migração para Máquina Oficial
- [ ] Máquina oficial preparada (Ubuntu 24.04 instalado)
- [ ] Backup da VM copiado
- [ ] Configuração restaurada/scripts executados
- [ ] Validação completa (mesmos testes da VM)
- [ ] Comparação VM vs Oficial (devem ser idênticos)

### Fase 1
- [ ] Contas criadas (admin + teen_user)
- [ ] Privilégios de sudo separados
- [ ] Permissões de arquivos críticos restringidas

### Fase 2
- [ ] DNS seguro ativo no Ubuntu
- [ ] `/etc/resolv.conf` imutável
- [ ] Teen_user não consegue contornar DNS

### Fase 3
- [ ] Auditd registrando comandos
- [ ] Zeek monitorando tráfego
- [ ] Logs acessíveis do MacBook

### Fase 4
- [ ] SSH com chaves ativo (sem senha)
- [ ] RDP funcionando
- [ ] Ambas conexões testadas do MacBook

### Fase 5
- [ ] RustDesk instalado em ambas máquinas
- [ ] Conexão P2P funcional
- [ ] Criptografia de ponta a ponta ativa

---

## 📚 REFERÊNCIAS E RECURSOS

- [Ubuntu 24.04 LTS Official Docs](https://ubuntu.com/server/docs)
- [Linux Audit Framework (auditd)](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/security_guide/chap-system_auditing)
- [Zeek Network Monitor](https://zeek.org/)
- [OpenSSH Manual](https://man.openbsd.org/ssh_config)
- [RustDesk Documentation](https://rustdesk.com/docs/en/)
- [GNOME Remote Desktop (RDP)](https://wiki.gnome.org/Projects/Gnome-remote-desktop)

---

## 🎯 PRÓXIMAS ETAPAS IMEDIATAS (FASE 0)

### Ação 1: Instalar Microsoft Remote Desktop
```bash
# Instalar via Homebrew
brew install microsoft-remote-desktop

# Verificar instalação
ls /Applications/Microsoft\ Remote\ Desktop.app && echo "✅ Instalado com sucesso"
```

### Ação 2: Criar Estrutura de Diretórios
```bash
# Criar diretórios do projeto
mkdir -p ~/Linux-Admin-Project/{configs,scripts,logs,ssh-keys,docs}

# Mover planejamento para o projeto
cp ~/projetos_new/linux_project/planejamento.md ~/Linux-Admin-Project/

# Listar estrutura criada
tree ~/Linux-Admin-Project/ 2>/dev/null || find ~/Linux-Admin-Project -type d
```

### Ação 3: Preparar Documentação
```bash
# Criar arquivo de anotações iniciais
touch ~/Linux-Admin-Project/docs/00-ambiente-inicial.md
touch ~/Linux-Admin-Project/docs/01-fase0-notas.md

# Criar log de atividades
touch ~/Linux-Admin-Project/logs/setup.log
```

### Ação 4: Obter Informações do Ubuntu
- [ ] IP do Ubuntu: `_____________`
- [ ] Hostname do Ubuntu: `_____________`
- [ ] Usuário admin planejado: `_____________`
- [ ] Nome do adolescente/usuário padrão: `_____________`
- [ ] Data de início da configuração: 2026-09-28

### Ação 5: Verificação Final antes de Fase 1
```bash
# Testar conectividade com Ubuntu
ping -c 3 <ubuntu-ip>

# Testar SSH (sem chaves ainda)
ssh -v <ubuntu-ip> -u root  # deve pedir senha
```

---

## 📝 ROADMAP COMPLETO

1. **Fase 0 (EM PROGRESSO):** ✅ Preparar ambiente e criar estrutura
2. **Fase 1:** Executar no Ubuntu - Contas e privilégios
3. **Fase 2:** Executar no Ubuntu - DNS seguro
4. **Fase 3:** Executar no Ubuntu - Auditoria (auditd + Zeek)
5. **Fase 4:** Executar MacBook ↔ Ubuntu - SSH + RDP
6. **Fase 5:** Executar MacBook ↔ Ubuntu - RustDesk (Mesma rede)
7. **Fase 6:** Executar Conex. Permanente - RustDesk + Tunnel SSH + DDNS (Redes diferentes)

---

## 📋 COMANDOS RÁPIDOS DE REFERÊNCIA

### MacBook - Gerenciamento do Projeto
```bash
# Acessar projeto
cd ~/Linux-Admin-Project

# Ver estrutura
tree -L 2

# Listar todas as fases
ls docs/fase*.md

# Ver último log
tail -50 logs/setup.log
```

### Gerar Histórico de Comandos
```bash
# Salvar histórico de SSH
history | grep ssh > ~/Linux-Admin-Project/logs/ssh-history.txt

# Salvar variáveis de ambiente
env > ~/Linux-Admin-Project/logs/environment.txt
```

---

## 🚀 ETAPA DE MIGRAÇÃO: VM → MÁQUINA OFICIAL

**Objetivo:** Depois de testar tudo na VM, replicar configuração na máquina oficial  
**Duração:** 1-2 horas  
**Risco:** BAIXO (todos os comandos já foram validados na VM)

### Estratégia de Migração

#### Opção 1: Backup e Restore (Mais Seguro)

```bash
# Passo 1: Na VM Ubuntu (após testes completos)
# Fazer backup da configuração

# Criar arquivo de backup
sudo tar -czf /tmp/ubuntu-config-backup.tar.gz \
  /etc/sudoers.d/ \
  /etc/ssh/sshd_config \
  /etc/audit/rules.d/ \
  /etc/netplan/ \
  /root/.ssh/ \
  /opt/zeek/etc/ \
  --exclude=/opt/zeek/logs

# Copiar para MacBook
scp /tmp/ubuntu-config-backup.tar.gz seu_usuario_mac@seu_macbook:~/Linux-Admin-Project/backups/

# Passo 2: Na máquina oficial Ubuntu (após instalação limpa)
# Restaurar backup

mkdir -p /tmp/restore
cd /tmp/restore
tar -xzf ~/ubuntu-config-backup.tar.gz

# Restaurar arquivo por arquivo manualmente ou com script
sudo cp /tmp/restore/etc/sudoers.d/* /etc/sudoers.d/
sudo cp /tmp/restore/etc/ssh/sshd_config /etc/ssh/sshd_config
# ... e assim por diante

# Reiniciar serviços
sudo systemctl restart ssh
sudo systemctl restart auditd
```

#### Opção 2: Scripts de Automação (Mais Eficiente)

Criar scripts que replicam cada fase automaticamente:

```bash
# ~/Linux-Admin-Project/scripts/replicate-fase1.sh
#!/bin/bash
# Script para replicar Fase 1 em nova máquina

TARGET_ADMIN="seu_novo_usuario_admin"
TARGET_TEEN="adolescente"

# Criar contas
sudo useradd -m -G sudo -s /bin/bash $TARGET_ADMIN
sudo useradd -m -s /bin/bash $TARGET_TEEN

# Configurar sudoers
sudo tee /etc/sudoers.d/teen_restrictions > /dev/null <<EOF
$TARGET_TEEN ALL=(ALL) !ALL
EOF

# ... mais comandos
```

#### Opção 3: Clone Direto (Mais Rápido - Se Mesmo Hardware)

Se a máquina oficial tiver mesmo hardware:
```bash
# Na VM, criar imagem completa
sudo dd if=/dev/sda of=/tmp/ubuntu-complete.img bs=4M

# Transferir para MacBook e depois para máquina oficial
# Restaurar imagem na máquina oficial
sudo dd if=/tmp/ubuntu-complete.img of=/dev/sda bs=4M
```

### Checklist de Migração

- [ ] Fases 1-5 completamente testadas na VM
- [ ] Todos os testes de funcionalidade passando
- [ ] Backup da VM criado e verificado
- [ ] Máquina oficial preparada (Ubuntu 24.04 instalado)
- [ ] Acesso SSH à máquina oficial disponível
- [ ] Backup/Scripts copiados para máquina oficial
- [ ] Restauração/Scripts executados
- [ ] Testes de verificação rodando (Fase 1-5 novamente)
- [ ] Comparação: VM vs Máquina Oficial (devem ser idênticas)
- [ ] Logs verificados para erros

### Validação Pós-Migração

```bash
# Na máquina oficial, executar verificações

# 1. Verificar contas criadas
cat /etc/passwd | grep -E 'admin_|adolescente'

# 2. Verificar SSH funcionando
sudo systemctl status ssh

# 3. Verificar auditoria ativa
sudo systemctl status auditd
sudo ausearch -k session_commands | head -5

# 4. Verificar DNS forçado
resolvectl status

# 5. Testar acesso remoto
ssh admin_seu_nome@localhost  # Deve conectar

# 6. Verificar RDP (se configurado)
sudo systemctl status xrdp

# 7. Verificar monitoramento
tail -20 /var/log/audit/audit.log
```

### Rollback (Se algo der errado)

```bash
# Se precisar voltar atrás:

# Opção 1: Restaurar VM do Snapshot
# Em Parallels/VMware: Revert to Snapshot "Ubuntu-24.04-Clean"
# E tentar de novo

# Opção 2: Restaurar backup da máquina oficial
# sudo tar -xzf backup.tar.gz -C /

# Opção 3: Reinstalar Ubuntu e aplicar scripts novamente
# Mais lento, mas mais seguro
```

---

## ❓ PERGUNTAS FREQUENTES - CENÁRIO DE REDES DIFERENTES

### P1: Qual é a melhor solução para Ubuntu em outra casa?

**R:** Recomendamos **RustDesk + SSH Reverse Tunnel**:
- **RustDesk:** Controle remoto visual, arquivo sharing (mais fácil de usar)
- **SSH Tunnel:** Backup automático, acesso terminal direto (mais confiável)
- Ambos reconectam automaticamente quando conexão cai
- Custo: GRATUITO (usando relay RustDesk público)

### P2: Preciso de VPN (WireGuard)?

**R:** Depende do seu caso:
- ✅ **Use WireGuard se:** Precisar acessar serviços internos, múltiplas máquinas, rede completa
- ❌ **Não precisa se:** Apenas controle remoto e terminal SSH suficiente

### P3: E se o IP do Ubuntu mudar todo dia?

**R:** Use **Dynamic DNS (DDNS)**:
- Instale cliente ddclient no Ubuntu
- Registre em serviço como No-IP ou DynDNS (gratuito)
- Seu hostname `ubuntu.no-ip.biz` sempre aponta para IP atual
- SSH e outros serviços usam hostname em vez de IP

### P4: Quanto de banda a conexão usa?

**R:** Depende do uso:
- **SSH Reverse Tunnel (idle):** <1 KB/min (keepalive)
- **RustDesk (desktop idle):** 5-10 KB/min
- **RustDesk (video streaming):** 100-500 KB/s (depende qualidade)
- **WireGuard (keepalive):** <1 KB/min

### P5: Consigo usar Fase 5 se Ubuntu estiver longe?

**R:** Não direto, mas pode tentar:
- Se ambas máquinas tiverem acesso ao mesmo "relay server" na internet
- RustDesk fallback para relay automático
- Mas será mais lento e dependerá de servidor de terceiros

### P6: E se a internet cair? Perco o acesso?

**R:** Temporariamente sim, mas:
- RustDesk + SSH Tunnel continuam tentando reconectar a cada 30 segundos
- Assim que internet voltar, conexão é restaurada automaticamente
- Logs registram todas as tentativas (útil para auditoria)

### P7: Consigo fazer tudo isso com automação?

**R:** SIM! Use **Ansible**:
- Criar playbooks para cada fase
- Automação completa (contas, firewall, auditoria, conexões remotas)
- Aplicar simultaneamente a múltiplos Ubuntu
- Definição de infraestrutura como código

### P8: Qual é mais seguro: SSH Tunnel ou RustDesk?

**R:** Ambos são seguros mas diferentes:
- **SSH Tunnel:** Criptografia OpenSSH (Curve25519), auditado há décadas
- **RustDesk:** Criptografia própria (salsa20, verificação, ponta-a-ponta)
- **Recomendação:** Use ambos (defense in depth)

### P9: Posso acessar Ubuntu mesmo com firewall ativo?

**R:** SIM, com SSH Reverse Tunnel:
- Ubuntu inicia conexão de SAÍDA (firewall geralmente permite)
- Cria túnel reverso no MacBook
- MacBook não precisa aceitar conexões de entrada
- É como Ubuntu "chamando" MacBook (não o contrário)

### P10: Preciso abrir portas no roteador do Ubuntu?

**R:** Com SSH Reverse Tunnel: **NÃO**
- Túnel usa conexão de saída (geralmente permitida)
- Com RustDesk P2P puro também não (se conseguir traversar NAT)
- Com WireGuard: **SIM** (udp/51820 ou porta customizada)
- **Melhor prática:** Usar SSH Tunnel (não requer abertura de porta)

---

## 🛠️ SCRIPTS E FERRAMENTAS FORNECIDAS

Todos os scripts e configurações estão em `~/Linux-Admin-Project/`:

### Para Fase 0-5 (Mesma Rede)
```
scripts/
├── gen-ssh-keys.sh           # Gerar chaves SSH
├── deploy-ssh-keys.sh        # Enviar chaves para Ubuntu
└── setup-ubuntu-admin.sh     # Setup inicial no Ubuntu
```

### Para Fase 6 (Redes Diferentes) - NOVOS
```
scripts/
├── ssh-tunnel-keeper.sh      # Manter SSH Tunnel ativo
├── check-connection.sh       # Verificar status de conexões
├── ddns-setup.sh            # Configurar Dynamic DNS
└── wireguard-setup.sh       # Configurar WireGuard (opcional)

configs/
├── ssh-tunnel-keeper.service # Daemon SSH Tunnel
├── connection-monitor.plist   # Monitor LaunchAgent (macOS)
├── ddclient.conf            # Config Dynamic DNS
└── wg0.conf                 # Config WireGuard
```

---

## 📞 SUPORTE E TROUBLESHOOTING

### SSH Reverse Tunnel não funciona?
```bash
# No Ubuntu, verificar status
sudo systemctl status ssh-tunnel-keeper
sudo journalctl -u ssh-tunnel-keeper -f

# Testar conexão SSH manual
ssh -v -i /root/.ssh/tunnel_key seu_usuario@seu_macbook

# Verificar se porta está aberta no MacBook
netstat -an | grep 2223
```

### RustDesk não reconecta automaticamente?
```bash
# No Ubuntu, verificar se serviço está ativo
sudo systemctl status rustdesk
pgrep rustdesk

# Checar logs
cat ~/.config/rustdesk/config.toml | grep -i reconnect

# Reiniciar
sudo systemctl restart rustdesk
```

### Dynamic DNS não atualizando?
```bash
# No Ubuntu
sudo systemctl status ddclient
sudo journalctl -u ddclient -f

# Forçar atualização
sudo ddclient -force

# Verificar se atualizado
nslookup ubuntu.no-ip.biz
```

---

**Última Atualização:** 2026-09-28 (Adicionada Fase 6 - Conexão Permanente Redes Diferentes)  
**Próxima Revisão:** Após Fase 0 concluída + Ubuntu acessível  
**Responsável:** vagnerantoniodasilva@yahoo.com.br

---

## 🎓 REFERÊNCIAS ADICIONAIS

### Documentação Oficial
- [RustDesk Documentation](https://rustdesk.com/docs/en/)
- [SSH Man Pages - reverse port forwarding](https://man.openbsd.org/ssh_config)
- [WireGuard Quickstart](https://www.wireguard.com/quickstart/)
- [Ubuntu Dynamic DNS](https://help.ubuntu.com/community/DynamicDNS)

### Ferramentas de Teste
- OpenSSL para testes de criptografia
- netstat/ss para verificar portas abertas
- tcpdump para análise de tráfego
- fail2ban para proteção contra brute-force

### Escalabilidade
- Ansible para automação multi-máquinas
- Prometheus + Grafana para monitoramento
- ELK Stack (Elasticsearch, Logstash, Kibana) para análise de logs centralizados
