# FASE 0.5: Setup Rápido de VM no MacBook

**Guia Prático para Criar Máquina Virtual Ubuntu 24.04 LTS**  
**Tempo:** 45 minutos a 1 hora  
**Dificuldade:** 🟢 Fácil

---

## 📋 PRÉ-REQUISITOS

- [ ] MacBook Apple Silicon (arm64) com macOS 26.5.2
- [ ] ~60 GB de espaço livre em disco
- [ ] 8 GB de RAM disponível
- [ ] Conexão internet (para baixar ISO e pacotes)
- [ ] Hypervisor: Parallels Desktop, VMware Fusion, ou UTM

---

## 🎯 OPÇÃO 1: PARALLELS DESKTOP (RECOMENDADO - Mais Fácil)

### Passo 1: Instalar Parallels Desktop

```bash
# Via Homebrew
brew install parallels

# OU via App Store
# https://apps.apple.com/app/parallels-desktop/id1085114284

# OU baixar trial
# https://www.parallels.com/products/desktop/download/

# Trial: 14 dias (suficiente para testes e refinamento)
```

### Passo 2: Baixar ISO Ubuntu

```bash
# No MacBook
mkdir -p ~/Linux-Admin-Project/isos

cd ~/Linux-Admin-Project/isos

# Download (escolha A ou B)
# A: Usando curl
curl -o ubuntu-24.04-server-arm64.iso \
  https://releases.ubuntu.com/24.04/ubuntu-24.04-live-server-arm64.iso

# B: Usando wget
wget https://releases.ubuntu.com/24.04/ubuntu-24.04-live-server-arm64.iso

# Verificar (arquivo deve ter ~2-3 GB)
ls -lh ubuntu-24.04-server-arm64.iso
```

### Passo 3: Criar VM no Parallels

**Opção A: Via Assistente Gráfico (Mais Fácil)**

1. Abrir Parallels Desktop
2. **File → New**
3. Selecionar **"Linux"**
4. Escolher **"Ubuntu 24.04"** (detecta automaticamente)
5. Se não detectar:
   - Clicar em **"Choose a file"**
   - Selecionar ISO baixada
6. Nomear VM: **"Ubuntu-Test-01"**
7. Configurações recomendadas:
   - **CPUs:** 4
   - **RAM:** 8 GB
   - **Disk:** 50 GB
   - **Network:** Shared Networking (permite ponte com host)
8. Clicar **"Create"**

**Opção B: Via Command Line**

```bash
# Criar VM via prlctl (ferramenta CLI do Parallels)
prlctl create Ubuntu-Test-01 --ostype linux \
  --cpu 4 \
  --memsize 8192 \
  --hdd-size 51200

# Conectar ISO à VM
prlctl set Ubuntu-Test-01 --device-add cdrom --image ~/Linux-Admin-Project/isos/ubuntu-24.04-server-arm64.iso

# Iniciar VM
prlctl start Ubuntu-Test-01 --nowin
```

### Passo 4: Instalar Ubuntu na VM

Quando a VM inicia, será apresentado o instalador Ubuntu:

```
=== UBUNTU SERVER 24.04 LTS ===

1. KEYBOARD LAYOUT
   → Selecionar: Português (Brazil) ou seu layout
   → Continue

2. NETWORK
   → Deixar DHCP ativado (automático)
   → Se quiser IP estático: selecionar e configurar
   → Continue

3. STORAGE
   → Selecionar: Use an entire disk
   → Selecionar o disco da VM (~50GB)
   → Continue

4. PROFILE
   → Your name: "Ubuntu"
   → Your server's name: "ubuntu-server"
   → Username: "ubuntu"  (ou "vagrant")
   → Password: "ubuntu123"  (usar algo simples para VM de testes)
   → Continue

5. SSH SERVER
   → ✅ MARCAR: "Install OpenSSH server"
   → ✅ MARCAR: "Allow password-based SSH login"
   → Continue

6. FEATURED SNAPS
   → Deixar em branco (não precisamos)
   → Continue

7. INSTALLATION COMPLETE
   → Clicar "Reboot Now"
```

### Passo 5: Verificar VM Iniciada

```bash
# Depois que Ubuntu reiniciar, fazer login
# username: ubuntu
# password: ubuntu123

# Verificar IP da VM
ip addr show

# Resultado esperado:
# eth0: inet 192.168.1.10/24 (ou similar)
```

### Passo 6: Testar Acesso SSH do MacBook

```bash
# No MacBook terminal
# Copiar o IP da VM (ex: 192.168.1.10)

ssh ubuntu@192.168.1.10
# Senha: ubuntu123

# Resultado esperado: você está logado na VM
# ubuntu@ubuntu-server:~$
```

---

## 🎯 OPÇÃO 2: VMWARE FUSION PRO (Alternativa - Profissional)

### Passo 1: Instalar VMware Fusion

```bash
# Trial de 30 dias com versão Pro
# https://www.vmware.com/products/fusion/fusion-evaluation.html

# Ou via Homebrew Cask
brew install vmware-fusion
```

### Passo 2-3: Mesmo dos Parallels (baixar ISO)

### Passo 4: Criar VM no VMware

1. Abrir VMware Fusion
2. **File → New...**
3. Selecionar ISO Ubuntu 24.04 arm64
4. VMware automaticamente detecta e sugere configuração
5. Nomear: **"Ubuntu-Test-01"**
6. Configurações (customize se necessário):
   - CPUs: 4
   - RAM: 8 GB
   - Disk: 50 GB
   - Network: Bridged (importante!)
7. Clicar **"Create"**

### Passo 5-6: Mesmos dos Parallels

---

## 🎯 OPÇÃO 3: UTM (Gratuito - Mais Técnico)

### Passo 1: Instalar UTM

```bash
# Via Homebrew
brew install utm

# Ou App Store
# https://apps.apple.com/app/utm-virtual-machines/id1564413744
```

### Passo 2: Seguir documentação UTM

https://docs.getutm.app/guides/ubuntu/

Passos básicos:
1. Abrir UTM
2. **Create a New Virtual Machine**
3. Selecionar **"Virtualize"** (não emular)
4. Selecionar **"Linux"**
5. **Browse** e selecionar ISO Ubuntu
6. Configurar Hardware:
   - CPU: 4
   - Memory: 8 GB
   - Storage: 50 GB
7. Network: **Bridged** (importante!)
8. Prosseguir com instalação Ubuntu (mesmos passos anteriores)

---

## ✅ CHECKLIST PÓS-INSTALAÇÃO

Após VM estar funcionando:

```bash
# Na VM (conectar via SSH do MacBook)
ssh ubuntu@192.168.1.10

# 1. Atualizar sistema
sudo apt update && sudo apt upgrade -y

# 2. Instalar ferramentas necessárias
sudo apt install -y \
  openssh-server \
  curl wget git \
  nano vim \
  net-tools \
  auditd \
  build-essential

# 3. Criar contas de teste
sudo useradd -m -G sudo -s /bin/bash admin_teste
sudo passwd admin_teste  # Definir senha

sudo useradd -m -s /bin/bash adolescente
sudo passwd adolescente

# 4. Habilitar SSH com senha (temporário)
sudo nano /etc/ssh/sshd_config
# Certificar que tem: PasswordAuthentication yes
# Salvar e sair (Ctrl+O, Enter, Ctrl+X)
sudo systemctl restart ssh

# 5. Desabilitar default Ubuntu user (segurança)
sudo usermod -L ubuntu
sudo usermod -s /usr/sbin/nologin ubuntu
```

### Snapshot de Segurança

**IMPORTANTE:** Criar snapshot antes de começar testes

**Parallels:**
```bash
# Via GUI: VM → Snapshots → Take Snapshot
# Nome: "Ubuntu-24.04-Base-Clean"
# Descrição: "Estado limpo após instalação"

# Via CLI:
prlctl snapshot Ubuntu-Test-01 create --name "Base-Clean"
```

**VMware:**
```bash
# Via GUI: VM → Snapshots → Take Snapshot
# Mesmos passos acima
```

**UTM:**
```bash
# Via GUI: Edit → Snapshots → Create Snapshot
```

---

## 📊 ESTRUTURA FINAL

```
MacBook (macOS 26.5.2)
│
├─ /Users/vagnerantantoniodasilva/
│  └─ Linux-Admin-Project/
│     ├─ isos/
│     │  └─ ubuntu-24.04-server-arm64.iso
│     ├─ configs/
│     ├─ scripts/
│     ├─ logs/
│     ├─ ssh-keys/
│     └─ docs/
│
└─ Parallels Desktop (VM)
   └─ Ubuntu-Test-01 (192.168.1.10)
      ├─ admin_teste (com sudo)
      └─ adolescente (sem privilégios)
```

---

## 🔗 PRÓXIMO PASSO

Depois que VM estiver funcionando e você conseguir fazer SSH:

1. Anotar IP da VM: `192.168.1.__________`
2. Anotar senha admin_teste: `__________`
3. Ir para **FASE 1** do planejamento principal
4. Usar VM para testar todas as fases 1-5

---

## 🆘 TROUBLESHOOTING RÁPIDO

| Problema | Solução |
|----------|---------|
| VM não inicia | Reiniciar Parallels/VMware |
| Sem internet na VM | Network → Settings → Bridged |
| SSH não funciona | `sudo systemctl restart ssh` na VM |
| VM lenta | Aumentar CPUs/RAM em Settings |
| Sem espaço em disco | Deletar outros arquivos ou expandir disco VM |
| Esqueceu senha | Iniciar VM em modo recovery (durante boot, pressionar 'e' ou 'c') |

---

**Tempo de Setup Total:** 30-60 minutos  
**Próxima Etapa:** Fase 1 (Gerenciamento de Contas) na VM  
**Data de Criação:** 2026-09-28
