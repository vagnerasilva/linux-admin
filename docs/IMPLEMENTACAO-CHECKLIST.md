# Checklist de Implementação Completo

**Guia passo a passo com checklist para cada fase**

---

## 📋 FASE 0: PREPARAÇÃO MACBOOK

### Pré-requisitos
- [ ] MacBook com macOS 26.5.x
- [ ] Acesso administrativo
- [ ] ~60 GB espaço livre em disco
- [ ] Conexão internet estável

### Executar Verificações
- [ ] Abrir Terminal
- [ ] Navegar para projeto: `cd ~/Linux-Admin-Project`
- [ ] Executar verificação: `bash scripts/00-verificar-ambiente.sh`
- [ ] Revisar output e notar qualquer erro

### Instalar Ferramentas
- [ ] Executar: `bash scripts/01-instalacoes.sh`
- [ ] Verificar que Homebrew foi atualizado
- [ ] Verificar que Microsoft Remote Desktop foi instalado
- [ ] Verificar que ~/.ssh/config foi criado

### Documentação
- [ ] Ler: [README.md](../README.md)
- [ ] Ler: [planejamento.md](../../linux_project/planejamento.md)
- [ ] Ler: [ROADMAP-VISUAL.md](../../linux_project/ROADMAP-VISUAL.md)
- [ ] Entender o fluxo geral do projeto

### Checklist Final Fase 0
- [ ] ✅ Homebrew atualizado
- [ ] ✅ Microsoft Remote Desktop instalado
- [ ] ✅ Estrutura de diretórios criada
- [ ] ✅ SSH config preparado
- [ ] ✅ Documentação lida e entendida

**Status Fase 0:** ⏳ Pronto para Fase 0.5

---

## 📋 FASE 0.5: MÁQUINA VIRTUAL

### Escolher Hypervisor
- [ ] Decidir entre Parallels Desktop, VMware Fusion ou UTM
- [ ] Instalar hypervisor escolhido
- [ ] Criar conta/licença se necessário

### Preparar ISO
- [ ] Criar diretório: `~/Linux-Admin-Project/isos`
- [ ] Baixar ISO Ubuntu 24.04 LTS arm64
- [ ] Verificar arquivo (~2-3 GB)
- [ ] Fazer backup da ISO (opcional)

### Criar VM
- [ ] Abrir hypervisor
- [ ] Criar nova VM
- [ ] Configurar:
  - [ ] CPUs: 4
  - [ ] RAM: 8 GB
  - [ ] Disk: 50 GB
  - [ ] Network: Bridge mode
- [ ] Selecionar ISO do Ubuntu
- [ ] Iniciar instalação

### Instalar Ubuntu
- [ ] Seguir installer do Ubuntu
- [ ] Configurar:
  - [ ] Keyboard layout
  - [ ] Network (DHCP ou estático 192.168.0.100)
  - [ ] Username: "ubuntu" ou "vagrant"
  - [ ] Password: "ubuntu123" (temporário)
  - [ ] ✅ SSH Server
  - [ ] ✅ Allow password SSH (temporário)
- [ ] Completar instalação
- [ ] Rebotar VM

### Configurar Rede da VM
- [ ] Anotar IP da VM: `___________________`
- [ ] Do MacBook, fazer ping: `ping 192.168.0.XXX`
- [ ] Do MacBook, conectar SSH: `ssh ubuntu@192.168.0.XXX`
- [ ] Atualizar scripts com IP correto

### Preparação da VM
- [ ] Na VM: `sudo apt update && sudo apt upgrade -y`
- [ ] Na VM: `sudo apt install -y openssh-server curl wget git nano vim net-tools`
- [ ] Criar conta admin: `sudo useradd -m -G sudo -s /bin/bash admin_teste`
- [ ] Definir senha: `sudo passwd admin_teste`
- [ ] Criar conta adolescente: `sudo useradd -m -s /bin/bash adolescente`
- [ ] Definir senha: `sudo passwd adolescente`

### Snapshot de Segurança
- [ ] Criar snapshot: "Ubuntu-24.04-Base-Clean"
- [ ] Adicionar descrição: "Estado limpo pós-instalação"
- [ ] Verificar snapshot foi criado

### Checklist Final Fase 0.5
- [ ] ✅ Hypervisor instalado
- [ ] ✅ ISO Ubuntu baixada
- [ ] ✅ VM criada com configuração correta
- [ ] ✅ Ubuntu 24.04 instalado
- [ ] ✅ SSH funcionando
- [ ] ✅ Contas criadas (admin_teste + adolescente)
- [ ] ✅ Snapshot "Base-Clean" criado
- [ ] ✅ IP da VM anotado

**Status Fase 0.5:** ✅ VM pronta para testes

---

## 📋 FASE 1: GERENCIAMENTO DE CONTAS (VM)

### Documentação
- [ ] Ler: [planejamento.md - Fase 1](../../linux_project/planejamento.md)
- [ ] Entender privilégios separados

### Criar Contas (se ainda não fez)
- [ ] Na VM: `sudo useradd -m -G sudo -s /bin/bash admin_teste`
- [ ] Na VM: `sudo passwd admin_teste`
- [ ] Na VM: `sudo useradd -m -s /bin/bash adolescente`
- [ ] Na VM: `sudo passwd adolescente`

### Configurar Sudoers
- [ ] Na VM: `sudo visudo -f /etc/sudoers.d/teen_restrictions`
- [ ] Adicionar: `adolescente ALL=(ALL) !ALL`
- [ ] Salvar e validar: `sudo visudo -c`

### Proteger Arquivos Críticos
- [ ] Na VM: `sudo chmod 700 /etc/sudoers.d/`
- [ ] Na VM: `sudo chmod 700 /root/.ssh`
- [ ] Na VM: `sudo chmod 640 /var/log/auth.log`

### Testar Permissões
- [ ] Conectar como admin_teste: OK
- [ ] Tentar sudo como admin_teste: OK
- [ ] Tentar sudo como adolescente: FALHA (esperado)

### Snapshot
- [ ] Criar snapshot: "After-Fase-1"

### Checklist Final Fase 1
- [ ] ✅ Contas criadas corretamente
- [ ] ✅ Privilégios separados
- [ ] ✅ Arquivos críticos protegidos
- [ ] ✅ Testes passando
- [ ] ✅ Snapshot criado

**Status Fase 1:** ✅ Testada e validada

---

## 📋 FASE 2: DNS SEGURO (VM)

### Documentação
- [ ] Ler: [planejamento.md - Fase 2](../../linux_project/planejamento.md)

### Configurar DNS Seguro
- [ ] Na VM: `sudo cp /etc/netplan/01-netcfg.yaml /etc/netplan/01-netcfg.yaml.backup`
- [ ] Editar Netplan para usar CleanBrowsing:
  ```yaml
  nameservers:
    addresses: [185.228.169.133, 185.228.168.133]
  ```
- [ ] Aplicar: `sudo netplan apply`
- [ ] Verificar: `resolvectl status`

### Bloquear Bypass
- [ ] Na VM: `sudo chattr +i /etc/resolv.conf`
- [ ] Verificar: `lsattr /etc/resolv.conf`

### Restringir Ferramentas
- [ ] Na VM: `sudo chmod 000 /usr/bin/curl` (ou criar wrapper)
- [ ] Na VM: `sudo chmod 000 /usr/bin/wget`

### Testar
- [ ] Verificar DNS forçado: `nslookup google.com`
- [ ] Tentar mudar DNS como adolescente: FALHA (esperado)

### Snapshot
- [ ] Criar snapshot: "After-Fase-2"

### Checklist Final Fase 2
- [ ] ✅ DNS seguro configurado
- [ ] ✅ Resolv.conf imutável
- [ ] ✅ Ferramentas de bypass bloqueadas
- [ ] ✅ Testes passando
- [ ] ✅ Snapshot criado

**Status Fase 2:** ✅ Testada e validada

---

## 📋 FASE 3: AUDITORIA (VM)

### Documentação
- [ ] Ler: [planejamento.md - Fase 3](../../linux_project/planejamento.md)

### Instalar Auditd
- [ ] Na VM: `sudo apt install -y auditd audispd-plugins`
- [ ] Na VM: `sudo systemctl enable auditd`
- [ ] Na VM: `sudo systemctl start auditd`
- [ ] Verificar: `sudo systemctl status auditd`

### Configurar Regras
- [ ] Editar: `/etc/audit/rules.d/audit.rules`
- [ ] Adicionar regras de execução
- [ ] Adicionar regras de mudanças de arquivo
- [ ] Recarregar: `sudo augenrules --load`
- [ ] Reiniciar: `sudo systemctl restart auditd`

### Testar Auditd
- [ ] Executar comando no Ubuntu
- [ ] Verificar log: `sudo ausearch -m execve`
- [ ] Filtrar por usuário: `sudo ausearch -ua adolescente`

### Instalar Zeek
- [ ] Na VM: `sudo apt install -y zeek`
- [ ] Na VM: `sudo systemctl enable zeek`
- [ ] Na VM: `sudo systemctl start zeek`

### Testar Zeek
- [ ] Gerar tráfego (ex: ping, curl)
- [ ] Verificar dns.log: `cat /opt/zeek/logs/current/dns.log`
- [ ] Verificar conn.log: `cat /opt/zeek/logs/current/conn.log`

### Snapshot
- [ ] Criar snapshot: "After-Fase-3"

### Checklist Final Fase 3
- [ ] ✅ Auditd instalado e rodando
- [ ] ✅ Regras configuradas
- [ ] ✅ Zeek instalado e rodando
- [ ] ✅ Logs sendo gerados
- [ ] ✅ Testes passando
- [ ] ✅ Snapshot criado

**Status Fase 3:** ✅ Testada e validada

---

## 📋 FASE 4: SSH + RDP (VM + MacBook)

### Gerar Chaves SSH (MacBook)
- [ ] No MacBook: `bash ~/Linux-Admin-Project/scripts/gen-ssh-keys.sh`
- [ ] Anotar localização das chaves
- [ ] Verificar permissões

### Configurar SSH (VM)
- [ ] Na VM: Editar `/etc/ssh/sshd_config`
- [ ] Configurações importantes:
  - [ ] Port 2222
  - [ ] PasswordAuthentication no
  - [ ] PubkeyAuthentication yes
  - [ ] AllowUsers admin_teste
- [ ] Validar sintaxe: `sudo sshd -t`
- [ ] Reiniciar: `sudo systemctl restart ssh`

### Adicionar Chave Pública (VM)
- [ ] Na VM: `mkdir -p ~/.ssh`
- [ ] Copiar chave pública: `echo "SSH_KEY" >> ~/.ssh/authorized_keys`
- [ ] Definir permissões: `chmod 600 ~/.ssh/authorized_keys`

### Testar SSH (MacBook)
- [ ] No MacBook: `ssh -i ssh-keys/ubuntu_admin_key admin_teste@192.168.0.100`
- [ ] Verificar que conectou sem pedir senha

### Instalar RDP (VM)
- [ ] Na VM: `sudo apt install -y xrdp xorgxrdp`
- [ ] Na VM: `sudo systemctl enable xrdp`
- [ ] Na VM: `sudo systemctl start xrdp`
- [ ] Verificar: `sudo systemctl status xrdp`

### Testar RDP (MacBook)
- [ ] No MacBook: Abrir Microsoft Remote Desktop
- [ ] Conectar para: `192.168.0.100:3389`
- [ ] Login com admin_teste
- [ ] Verificar que conectou

### Snapshot
- [ ] Criar snapshot: "After-Fase-4"

### Checklist Final Fase 4
- [ ] ✅ Chaves SSH geradas
- [ ] ✅ SSH configurado com chaves
- [ ] ✅ Teste SSH bem-sucedido
- [ ] ✅ RDP instalado e rodando
- [ ] ✅ Teste RDP bem-sucedido
- [ ] ✅ Snapshot criado

**Status Fase 4:** ✅ Testada e validada

---

## 📋 FASE 5: RUSTDESK (VM + MacBook)

### Instalar RustDesk (VM)
- [ ] Na VM: Baixar `.deb` do RustDesk
- [ ] Na VM: `sudo apt install ./rustdesk-*.deb`
- [ ] Executar: `rustdesk &`
- [ ] Anotar ID gerado: `___________________`

### Configurar Auto-Start (VM)
- [ ] Criar serviço systemd para RustDesk
- [ ] Ativar: `sudo systemctl enable rustdesk`
- [ ] Iniciar: `sudo systemctl start rustdesk`

### Definir Senha (VM)
- [ ] Na VM, abrir RustDesk GUI
- [ ] Settings → Security → Set Password
- [ ] Definir senha forte
- [ ] Anotar: `___________________`

### Instalar RustDesk (MacBook)
- [ ] No MacBook: `brew install rustdesk`
- [ ] Abrir RustDesk

### Testar RustDesk (MacBook)
- [ ] Inserir ID da VM
- [ ] Inserir senha
- [ ] Testar controle remoto (mouse, teclado)
- [ ] Testar transferência de arquivos

### Snapshot
- [ ] Criar snapshot: "After-Fase-5"

### Checklist Final Fase 5
- [ ] ✅ RustDesk instalado em VM
- [ ] ✅ ID anotado
- [ ] ✅ Senha definida
- [ ] ✅ RustDesk instalado em MacBook
- [ ] ✅ Teste bem-sucedido
- [ ] ✅ Controle remoto funciona
- [ ] ✅ Snapshot criado

**Status Fase 5:** ✅ Testada e validada

---

## 📋 VALIDAÇÃO FINAL (VM)

### Testes Funcionais
- [ ] SSH direto funciona
- [ ] RDP funciona
- [ ] RustDesk funciona
- [ ] DNS está bloqueado (testar: tentar mudar com adolescente)
- [ ] Auditoria está registrando

### Testes de Segurança
- [ ] adolescente não consegue fazer sudo
- [ ] adolescente não consegue mudar DNS
- [ ] adolescente não consegue usar curl/wget
- [ ] Contas não conseguem acessar ssh keys

### Testes de Logs
- [ ] Auditd registrando execuções
- [ ] Zeek registrando conexões
- [ ] Logs acessíveis do MacBook via SSH

### Backup Final
- [ ] Criar backup completo da VM
- [ ] Salvar em: `~/Linux-Admin-Project/backups/`

### Snapshot Final
- [ ] Criar snapshot: "VM-Ready-For-Migration"

### Checklist Validação
- [ ] ✅ Todos testes funcionais passando
- [ ] ✅ Todos testes de segurança passando
- [ ] ✅ Logs verificados e corretos
- [ ] ✅ Backup criado
- [ ] ✅ Snapshot final criado

**Status:** ✅ VM Pronta para Migração

---

## 📋 MIGRAÇÃO (VM → Máquina Oficial)

### Preparação
- [ ] Máquina oficial com Ubuntu 24.04 instalado
- [ ] Acesso SSH à máquina oficial
- [ ] Backup da VM transferido

### Migração
- [ ] Executar scripts de replicação:
  - [ ] `bash scripts/replicate-fase1.sh`
  - [ ] `bash scripts/replicate-fase2.sh`
  - [ ] `bash scripts/replicate-fase3.sh`
  - [ ] `bash scripts/replicate-fase4.sh`
  - [ ] `bash scripts/replicate-fase5.sh`
- [ ] Ou restaurar backup completo

### Validação Pós-Migração
- [ ] Testar SSH na máquina oficial
- [ ] Testar RDP na máquina oficial
- [ ] Testar RustDesk na máquina oficial
- [ ] Verificar logs
- [ ] Comparar com VM (devem ser idênticas)

### Checklist Migração
- [ ] ✅ Scripts replicação executados
- [ ] ✅ Testes de validação passando
- [ ] ✅ Máquina oficial operacional
- [ ] ✅ Logs verificados

**Status:** ✅ Sistema em Produção

---

## 📋 OPERAÇÃO CONTÍNUA

### Monitoramento
- [ ] Executar diariamente: `bash scripts/check-connection.sh`
- [ ] Revisar logs semanalmente
- [ ] Verificar backups

### Manutenção
- [ ] Atualizar Ubuntu: `sudo apt update && sudo apt upgrade`
- [ ] Revisar auditoria: `sudo ausearch -m execve`
- [ ] Verificar dns: `resolvectl status`

### Segurança
- [ ] Rodar fail2ban
- [ ] Verificar conexões SSH
- [ ] Revisar sudo logs

### Checklist Operação
- [ ] ✅ Monitoramento ativo
- [ ] ✅ Backups regulares
- [ ] ✅ Logs auditados
- [ ] ✅ Segurança verificada

**Status:** ✅ Sistema Operacional

---

## 🎯 RESUMO DE STATUS

| Etapa | Status | Data | Observações |
|-------|--------|------|-------------|
| Fase 0 | ⏳ | - | Preparação MacBook |
| Fase 0.5 | ⏳ | - | VM criada |
| Fase 1 | ⏳ | - | Contas |
| Fase 2 | ⏳ | - | DNS |
| Fase 3 | ⏳ | - | Auditoria |
| Fase 4 | ⏳ | - | SSH + RDP |
| Fase 5 | ⏳ | - | RustDesk |
| Validação | ⏳ | - | VM testada |
| Migração | ⏳ | - | Para oficial |
| Operação | ⏳ | - | Em produção |

---

**Última Atualização:** 2026-09-28  
**Versão:** 1.0  
**Status:** Pronto para Implementação
