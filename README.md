# Linux Admin Project: Auditoria, Controle Parental e Acesso Remoto

**Projeto de Administração de Sistemas Linux com Monitoramento, Controle Parental e Acesso Remoto Seguro**

---

## 📋 O que é este projeto?

Sistema completo para configurar um ambiente de administração remota entre:
- **MacBook** (máquina administradora)
- **Ubuntu 24.04 LTS** (máquina do usuário final, com controle parental)

Com 5 camadas de segurança:
1. Gerenciamento de Contas (privilégios separados)
2. Controle de Conteúdo (DNS seguro)
3. Auditoria de Sistema (logs de tudo)
4. Acesso Remoto Seguro (SSH + RDP)
5. Acesso Remoto Extrarede (RustDesk + Tunnels)

---

## 🎯 Objetivo Final

Criar um sistema onde:
- ✅ Admin (MacBook) consegue acessar Ubuntu remotamente (visual + terminal)
- ✅ Usuário final (Ubuntu) não consegue fazer bypass de proteções
- ✅ Todas as ações são auditadas e registradas
- ✅ Funciona em múltiplas redes (mesma casa ou casas diferentes)

---

## 📊 Status do Projeto

| Fase | Descrição | Status | Duração |
|------|-----------|--------|---------|
| **0** | Preparação do MacBook | ⏳ Próximo | 2-4h |
| **0.5** | Máquina Virtual de Testes | ⏳ Depois | 2-3h |
| **1-5 (VM)** | Testes em Ambiente Controlado | ⏳ Depois | 9-16h |
| **Migração** | Copiar para Máquina Oficial | ⏳ Depois | 1-2h |
| **Operação** | Sistema em Produção | ⏳ Futuro | - |

---

## 📚 Documentação Principal

1. **[planejamento.md](../linux_project/planejamento.md)** ← Comece aqui
   - Análise completa do projeto
   - Todas as 6 fases detalhadas
   - Scripts e comandos prontos

2. **[ROADMAP-VISUAL.md](../linux_project/ROADMAP-VISUAL.md)**
   - Visão geral do projeto
   - Timeline completa
   - Fluxo de implementação

3. **[FASE-0.5-SETUP-VM-RAPIDO.md](../linux_project/FASE-0.5-SETUP-VM-RAPIDO.md)**
   - Setup de máquina virtual
   - Passo a passo prático
   - 45 minutos de setup

4. **[FASE6-CONEXAO-REMOTA-PERMANENTE.md](../linux_project/FASE6-CONEXAO-REMOTA-PERMANENTE.md)**
   - Para quando Ubuntu estiver em outra casa
   - Conexão permanente confiável
   - SSH Reverse Tunnel + RustDesk + DDNS

---

## 🗂️ Estrutura de Diretórios

```
Linux-Admin-Project/
├── README.md                           ← Você está aqui
├── planejamento.md                     ← Guia completo
├── ROADMAP-VISUAL.md                   ← Visão geral
├── FASE-0.5-SETUP-VM-RAPIDO.md        ← VM setup
│
├── isos/                               ← Imagens do SO
│   └── (Ubuntu 24.04 LTS ISO será aqui)
│
├── configs/                            ← Arquivos de configuração
│   ├── netplan-01-netcfg.yaml         ← DNS seguro
│   ├── sshd_config                    ← SSH hardened
│   ├── audit.rules                    ← Auditoria
│   ├── xrdp.ini                       ← RDP config
│   ├── ddclient.conf                  ← Dynamic DNS (template)
│   └── wireguard-wg0.conf             ← WireGuard (template)
│
├── scripts/                            ← Scripts executáveis
│   ├── 00-verificar-ambiente.sh       ← Status do MacBook
│   ├── 01-instalacoes.sh              ← Instalar ferramentas
│   ├── gen-ssh-keys.sh                ← Gerar chaves SSH
│   ├── deploy-ssh-keys.sh             ← Enviar chaves
│   ├── ssh-tunnel-keeper.sh           ← SSH tunnel permanente
│   ├── check-connection.sh            ← Verificar conexões
│   ├── replicate-fase1.sh             ← Replicar Fase 1
│   ├── replicate-fase2.sh             ← Replicar Fase 2
│   ├── replicate-fase3.sh             ← Replicar Fase 3
│   ├── replicate-fase4.sh             ← Replicar Fase 4
│   ├── replicate-fase5.sh             ← Replicar Fase 5
│   └── migrate-to-official.sh         ← Migração completa
│
├── ssh-keys/                           ← Chaves SSH
│   ├── ubuntu_admin_key                ← Private key (confidencial)
│   ├── ubuntu_admin_key.pub            ← Public key
│   ├── ubuntu_tunnel_key               ← Tunnel private key
│   └── ubuntu_tunnel_key.pub           ← Tunnel public key
│
├── backups/                            ← Backups
│   ├── ubuntu-config-backup.tar.gz    ← Config backup
│   ├── vm-snapshot-base.vmsnapshot    ← VM snapshot
│   └── rollback-log.txt               ← Histórico de rollbacks
│
├── logs/                               ← Registros
│   ├── setup.log                      ← Setup progress
│   ├── phase-1.log                    ← Logs por fase
│   ├── connection-monitor.log         ← Status de conexão
│   ├── migration.log                  ← Logs de migração
│   └── ssh-tunnel-keeper.log          ← SSH tunnel logs
│
└── docs/                               ← Documentação
    ├── 00-ambiente-inicial.md         ← Status inicial
    ├── 01-fase0-notas.md              ← Notas Fase 0
    ├── 02-fase1-contas.md             ← Notas Fase 1
    ├── 03-fase2-dns.md                ← Notas Fase 2
    ├── 04-fase3-auditoria.md          ← Notas Fase 3
    ├── 05-fase4-ssh-rdp.md            ← Notas Fase 4
    ├── 06-fase5-rustdesk.md           ← Notas Fase 5
    ├── vm-checklist.md                ← Checklist VM
    ├── migration-checklist.md         ← Checklist migração
    ├── troubleshooting.md             ← Problemas e soluções
    └── referencia-rapida.md           ← Comandos úteis
```

---

## 🚀 Começar Agora

### Passo 1: Ler Documentação
```bash
# Veja o planejamento completo
cat ~/Linux-Admin-Project/../../linux_project/planejamento.md | less

# Ou veja visão geral
cat ~/Linux-Admin-Project/../../linux_project/ROADMAP-VISUAL.md | less
```

### Passo 2: Fase 0 - Preparar MacBook
```bash
# Verificar ambiente
bash scripts/00-verificar-ambiente.sh

# Instalar ferramentas necessárias
bash scripts/01-instalacoes.sh
```

### Passo 3: Fase 0.5 - Criar VM
Seguir [FASE-0.5-SETUP-VM-RAPIDO.md](../linux_project/FASE-0.5-SETUP-VM-RAPIDO.md)

### Passo 4: Fases 1-5 - Testar em VM
Seguir [planejamento.md](../linux_project/planejamento.md) Fases 1-5

### Passo 5: Migração
Usar scripts `replicate-fase*.sh` na máquina oficial

---

## 📖 Guias Rápidos

### Para Iniciantes
1. Leia [ROADMAP-VISUAL.md](../linux_project/ROADMAP-VISUAL.md) - 10 min
2. Leia [planejamento.md](../linux_project/planejamento.md) - 30 min
3. Comece Fase 0

### Para Experientes em Linux
1. Leia [planejamento.md](../linux_project/planejamento.md) resumido
2. Pule para Fase 0.5 (VM setup)
3. Execute scripts `replicate-*.sh`

### Para Implementação Rápida
1. [FASE-0.5-SETUP-VM-RAPIDO.md](../linux_project/FASE-0.5-SETUP-VM-RAPIDO.md) - 1h
2. Scripts automatizados - 5h
3. Testes - 2h

---

## 🔧 Ferramentas Necessárias

**MacBook:**
- ✅ OpenSSH (já incluído)
- ⏳ Microsoft Remote Desktop (instalar: `brew install microsoft-remote-desktop`)
- ⏳ Hypervisor: Parallels Desktop, VMware Fusion, ou UTM

**Ubuntu VM/Oficial:**
- SSH server
- auditd + Zeek (para auditoria)
- xrdp (para RDP)
- RustDesk (para controle remoto)

---

## 📞 Comandos Úteis

```bash
# Ver documentação
ls -la docs/

# Ver scripts disponíveis
ls -la scripts/

# Ver configurações de exemplo
ls -la configs/

# Executar verificação de ambiente
bash scripts/00-verificar-ambiente.sh

# Ver log de setup
tail -f logs/setup.log

# Gerar chaves SSH
bash scripts/gen-ssh-keys.sh

# Verificar status de conexão
bash scripts/check-connection.sh
```

---

## 🆘 Tendo Problemas?

1. **Verifique docs/troubleshooting.md** - Problemas comuns e soluções
2. **Revise os logs** - `cat logs/setup.log`
3. **Reinicie a fase** - Máquina virtual tem snapshots para rollback
4. **Leia planejamento.md seção de FAQ**

---

## 📈 Progresso Típico

```
Dia 1:
  ├─ Fase 0: Setup MacBook (2-4h)
  └─ Fase 0.5: Setup VM (2-3h)

Dia 2-3:
  ├─ Fases 1-3 na VM (5-7h)
  └─ Backup VM

Dia 3-4:
  ├─ Fases 4-5 na VM (3-5h)
  └─ Validação completa (1-2h)

Dia 5:
  ├─ Migração para máquina oficial (1-2h)
  └─ Testes de validação (1-2h)

Total: 15-27 horas de trabalho (5-7 dias)
```

---

## ✅ Checklist Antes de Começar

- [ ] Leu [ROADMAP-VISUAL.md](../linux_project/ROADMAP-VISUAL.md)
- [ ] Leu [planejamento.md](../linux_project/planejamento.md)
- [ ] MacBook tem espaço em disco (~60 GB para VM)
- [ ] MacBook tem RAM suficiente (8 GB + 8 GB para VM)
- [ ] Conexão internet estável
- [ ] Acesso administrativo no MacBook
- [ ] Tem máquina Ubuntu para teste ou já instalada

---

## 🎓 O que você aprenderá

✅ Segurança de Linux (privilégios, firewall, auditoria)  
✅ Acesso remoto seguro (SSH, RDP, VPN)  
✅ Auditoria de sistemas (auditd, Zeek)  
✅ Monitoramento de rede  
✅ Administração remota (MacBook → Ubuntu)  
✅ Virtualização (VM setup e testes)  
✅ Scripting bash (automação)  
✅ DNS e filtragem de conteúdo  

---

## 📝 Notas Importantes

- ⚠️ **VM é para testes**: Nunca execute tudo direto na máquina oficial
- ⚠️ **Backups são críticos**: Sempre fazer snapshot/backup antes de mudanças
- ⚠️ **Documentar tudo**: Cada passo deve deixar rastro em logs
- ⚠️ **Testar passo a passo**: Não pule fases
- ⚠️ **Rollback**: Snapshots da VM permitem voltar se algo falhar

---

## 📞 Próximos Passos

**Agora:**
1. ✅ Estrutura criada
2. ⏳ Leia [planejamento.md](../linux_project/planejamento.md)
3. ⏳ Execute Fase 0

**Próximo:**
- Executar scripts de setup
- Criar e preparar VM
- Testar todas as fases

---

## 📜 Versão e Data

- **Data de Criação:** 2026-09-28
- **Versão:** 1.0
- **Status:** Pronto para Implementação
- **Autor:** vagnerantoniodasilva@yahoo.com.br

---

## 🤝 Suporte

Para dúvidas ou problemas:
1. Consulte [troubleshooting.md](docs/troubleshooting.md)
2. Revise o planejamento específico da fase
3. Verifique os logs em `logs/`

---

**Bem-vindo ao Linux Admin Project! 🚀**

Comece lendo [planejamento.md](../linux_project/planejamento.md) e execute as fases uma por uma.
# linux-admin
