# ROADMAP VISUAL: MacBook → VM → Máquina Oficial

**Visão Geral do Projeto Completo**

---

## 📊 FLUXO GERAL

```
┌─────────────────────────────────────────────────────────────────────────────────┐
│                         PROJETO: ADMIN LINUX + CONTROLE PARENTAL                │
│                    Configuração em Três Etapas de Implementação                 │
└─────────────────────────────────────────────────────────────────────────────────┘

                    ┌─────────────────────────┐
                    │   FASE 0: PREPARAÇÃO    │
                    │     MacBook Setup       │
                    │   Duração: 2-4 horas    │
                    └────────────┬────────────┘
                                 │
                    ✅ Microsoft Remote Desktop
                    ✅ Estrutura de diretórios
                    ✅ Projeto pronto
                                 │
                                 ▼
                    ┌─────────────────────────┐
                    │  FASE 0.5: MÁQUINA      │
                    │   VIRTUAL DE TESTES     │
                    │   Duração: 2-3 horas    │
                    └────────────┬────────────┘
                                 │
                    ✅ VM Ubuntu 24.04 criada
                    ✅ SSH funcionando
                    ✅ Contas de teste criadas
                    ✅ Snapshot "Base-Clean"
                                 │
                                 ▼
        ┌────────────────────────────────────────────────────────┐
        │        ETAPA DE TESTES (VM Ubuntu)                     │
        │   Fase 1: Contas e Privilégios         (1-2 horas)     │
        │   Fase 2: DNS Seguro                   (1-2 horas)     │
        │   Fase 3: Auditoria (auditd + Zeek)   (2-3 horas)     │
        │   Fase 4: SSH + RDP                    (2-3 horas)     │
        │   Fase 5: RustDesk                     (1-2 horas)     │
        │                                                         │
        │   Verificação de Funcionalidade         (1-2 horas)    │
        │   Duração Total: 9-16 horas                            │
        └────────────┬─────────────────────────────────────────┘
                     │
        ✅ Todas as fases testadas
        ✅ Funcionalidade validada
        ✅ Logs verificados
        ✅ Backup criado
                     │
                     ▼
        ┌────────────────────────────────────────────────────────┐
        │    MIGRAÇÃO: VM → MÁQUINA OFICIAL                      │
        │    Duração: 1-2 horas                                  │
        └────────────┬─────────────────────────────────────────┘
                     │
        ✅ Máquina oficial preparada
        ✅ Backup/Scripts copiados
        ✅ Configuração restaurada
        ✅ Testes de validação
                     │
                     ▼
        ┌────────────────────────────────────────────────────────┐
        │   OPERAÇÃO: MÁQUINA OFICIAL                            │
        │   Fases 1-5 + Fase 6 (opcional)                        │
        │   Monitoramento ativo                                  │
        │   Auditoria contínua                                   │
        └────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────────────────────┐
│  TEMPO TOTAL: 15-27 horas para implementação completa (incluindo testes)        │
│  RISCO: Muito Baixo (tudo testado em VM antes de máquina oficial)               │
└─────────────────────────────────────────────────────────────────────────────────┘
```

---

## 🎯 FASE 0: PREPARAÇÃO MACBOOK

```
┌──────────────────────────────────────┐
│  MacBook (Admin Central)             │
│  macOS 26.5.2 - arm64 (M1/M2/M3/M4)  │
└──────────────────────────────────────┘
         │
         ├─ 1. Instalar Microsoft Remote Desktop
         │      brew install microsoft-remote-desktop
         │
         ├─ 2. Criar estrutura de diretórios
         │      mkdir -p ~/Linux-Admin-Project/{configs,scripts,logs}
         │
         ├─ 3. Preparar ISO Ubuntu
         │      ~/Linux-Admin-Project/isos/ubuntu-24.04-server-arm64.iso
         │
         └─ 4. Status: ✅ PRONTO PARA FASE 0.5

         Tempo: 2-4 horas
         Risco: ✅ NENHUM (apenas install/setup)
```

---

## 🖥️ FASE 0.5: MÁQUINA VIRTUAL DE TESTES

```
┌──────────────────────────────────────┐
│  Hypervisor (Parallels/VMware/UTM)   │
└──────────────────────────────────────┘
         │
         └─ ┌────────────────────────────────────────┐
            │  VM: Ubuntu-Test-01                    │
            │  IP: 192.168.1.10 (DHCP/Dinâmico)      │
            │  CPUs: 4 | RAM: 8GB | Disk: 50GB       │
            ├────────────────────────────────────────┤
            │  Contas:                               │
            │  ├─ root (admin para setup)            │
            │  ├─ admin_teste (com sudo)            │
            │  └─ adolescente (sem privilégios)     │
            │                                        │
            │  Snapshots:                            │
            │  ├─ "Ubuntu-24.04-Base-Clean"         │
            │  └─ "After-Fase-1", "After-Fase-2" ... │
            └────────────────────────────────────────┘

         Tempo: 2-3 horas
         Risco: ✅ NENHUM (é teste, pode recomeçar)
```

---

## 🧪 FASES 1-5: TESTES NA VM

```
VM Ubuntu (192.168.1.10)
│
├─ FASE 1: Gerenciamento de Contas (1-2h)
│  ├─ Criar admin_teste com sudo
│  ├─ Criar adolescente sem privilégios
│  ├─ Proteger arquivos críticos
│  └─ ✅ SNAPSHOT: "After-Fase-1"
│
├─ FASE 2: DNS Seguro (1-2h)
│  ├─ Configurar Netplan com DNS (CleanBrowsing)
│  ├─ Bloquear /etc/resolv.conf
│  ├─ Restringir ferramentas de bypass
│  └─ ✅ SNAPSHOT: "After-Fase-2"
│
├─ FASE 3: Auditoria (2-3h)
│  ├─ Instalar auditd
│  ├─ Configurar regras de execução
│  ├─ Instalar Zeek
│  ├─ Testar logs
│  └─ ✅ SNAPSHOT: "After-Fase-3"
│
├─ FASE 4: SSH + RDP (2-3h)
│  ├─ Configurar SSH com chaves
│  ├─ Gerar chaves no MacBook
│  ├─ Instalar xrdp para RDP
│  ├─ Testar conexões
│  └─ ✅ SNAPSHOT: "After-Fase-4"
│
├─ FASE 5: RustDesk (1-2h)
│  ├─ Instalar RustDesk
│  ├─ Configurar auto-start
│  ├─ Definir senha permanente
│  ├─ Testar controle remoto
│  └─ ✅ SNAPSHOT: "After-Fase-5"
│
└─ VALIDAÇÃO (1-2h)
   ├─ Testar todas as conexões (SSH + RDP + RustDesk)
   ├─ Verificar logs de auditoria
   ├─ Testar DNS bloqueio
   ├─ Simular tentativa de bypass
   ├─ Confirmar all working
   └─ ✅ BACKUP COMPLETO CRIADO

Total VM: 9-16 horas
Status: Testado e Validado
```

---

## 📦 MIGRAÇÃO: VM → MÁQUINA OFICIAL

```
┌─────────────────────────────────────────────────────────────┐
│  VM Ubuntu (Testada)                                        │
│  ├─ Backup completo: ~/Linux-Admin-Project/backups/         │
│  ├─ Scripts de réplica: ~/Linux-Admin-Project/scripts/      │
│  └─ Documentação: ~/Linux-Admin-Project/docs/               │
└────────────────┬────────────────────────────────────────────┘
                 │
                 ├─ Opção 1: Backup + Restore
                 │  Tar.gz da configuração → Restore em máquina
                 │
                 ├─ Opção 2: Scripts de Automação
                 │  Rodar replicate-fase*.sh na máquina
                 │
                 └─ Opção 3: Clone Direto (se mesmo hardware)
                    dd imagem completa → Restaurar em máquina
                 │
                 ▼
┌─────────────────────────────────────────────────────────────┐
│  Máquina Oficial Ubuntu 24.04                               │
│  ├─ Fases 1-5 replicadas                                    │
│  ├─ Testes de validação rodando                             │
│  ├─ Comparação com VM: Devem ser idênticas                  │
│  ├─ Rollback possível se algo falhar                        │
│  └─ ✅ PRONTO PARA OPERAÇÃO                                 │
└─────────────────────────────────────────────────────────────┘

Tempo: 1-2 horas
Risco: ✅ BAIXO (tudo foi testado em VM)
```

---

## 🚀 OPERAÇÃO FINAL: MÁQUINA OFICIAL

```
┌──────────────────────────────────────────────────────────────────┐
│  AMBIENTE DE PRODUÇÃO: Máquina Oficial Ubuntu 24.04              │
├──────────────────────────────────────────────────────────────────┤
│                                                                   │
│  ┌─ Administração (MacBook) ────────────────► Ubuntu (Oficial) ┐ │
│  │                                                              │ │
│  │  SSH (Port 2222)                    [Chaves Seguras]       │ │
│  │  RDP (Port 3389)                    [Criptografado]        │ │
│  │  RustDesk                           [P2P + Relay]          │ │
│  │  SSH Reverse Tunnel (Fase 6)        [Auto-reconnect]       │ │
│  │  Dynamic DNS (Fase 6)               [IP Dinâmico]          │ │
│  │                                                              │ │
│  └──────────────────────────────────────────────────────────────┘ │
│                          │                                         │
│      ┌──────────────────┼──────────────────┐                       │
│      │                  │                  │                       │
│      ▼                  ▼                  ▼                       │
│  ┌────────────┐   ┌────────────┐   ┌────────────┐                │
│  │ Auditoria  │   │ Bloqueio   │   │ Controle   │                │
│  │ (auditd +  │   │ Parental   │   │ Remoto     │                │
│  │  Zeek)     │   │ (DNS)      │   │ Permanente │                │
│  └────────────┘   └────────────┘   └────────────┘                │
│      │                  │                  │                       │
│      │ audit.log        │ resolv.conf      │ ssh logs              │
│      │ dns.log          │ iptables rules   │ rustdesk logs         │
│      │ conn.log         │                  │                       │
│      │                  │                  │                       │
│      └──────────────────┼──────────────────┘                       │
│                         │                                          │
│                    Monitoramento Centralizado                      │
│                  (logs + alertas no MacBook)                       │
│                                                                    │
└──────────────────────────────────────────────────────────────────┘

Status: ✅ OPERACIONAL
Monitoramento: Ativo
Auditoria: Contínua
Alertas: Funcionando
Backup: Automático (Fase 6 opcional)
```

---

## 📈 TIMELINE COMPLETA

```
Data          Semana    Fase/Atividade              Duração    Status
────────────────────────────────────────────────────────────────────────
2026-09-28    Semana 1  Fase 0: Setup MacBook      2-4h       ⏳
2026-09-29    Semana 1  Fase 0.5: Setup VM         2-3h       ⏳
2026-09-30    Semana 1  Fases 1-3: Teste VM        3-5h       ⏳
2026-10-01    Semana 1  Fases 4-5: Teste VM        3-5h       ⏳
2026-10-02    Semana 1  Validação + Backup         1-2h       ⏳
2026-10-03    Semana 2  Migração → Máquina Oficial 1-2h       ⏳ Futuro
2026-10-04    Semana 2  Validação Máquina Oficial  1-2h       ⏳ Futuro
2026-10-05    Semana 2  Operação Inicial           -          ⏳ Futuro

Total: 14-25 horas (5-7 dias de trabalho)
```

---

## 🎓 MATRIZ DE CONHECIMENTO

```
Pessoa      Fase 0    Fase 0.5   Fases 1-5(VM)   Migração   Operação
─────────────────────────────────────────────────────────────────────
Admin       ✅ Faz    ✅ Faz     ✅ Faz           ✅ Faz     ✅ Monitora
MacBook     (você)    (você)     (você)          (você)     (você)
                 
Adolescente  -         -         ⚠️ Testado      ⏳ Pronto   ✅ Usa
(Ubuntu)     -         -         (na VM)         (oficial)  (monitorado)
```

---

## ✅ CRITÉRIOS DE SUCESSO

### Fase 0 ✅
- [ ] Microsoft Remote Desktop instalado
- [ ] Estrutura de diretórios criada
- [ ] Documentação acessível

### Fase 0.5 ✅
- [ ] VM criada e inicializando
- [ ] Ubuntu 24.04 LTS instalado
- [ ] SSH funcionando
- [ ] Snapshot "Base-Clean" criado

### Fases 1-5 (VM) ✅
- [ ] Todas as fases executadas com sucesso
- [ ] Cada fase tem snapshot próprio
- [ ] Testes de funcionalidade passando
- [ ] Logs verificados e sem erros críticos
- [ ] Backup completo criado

### Migração ✅
- [ ] Máquina oficial preparada
- [ ] Configuração restaurada
- [ ] Testes validando

### Operação ✅
- [ ] Admin consegue conectar via SSH/RDP/RustDesk
- [ ] Adolescente não consegue fazer bypass
- [ ] Logs auditando corretamente
- [ ] Monitoramento ativo

---

## 🔄 FLUXO DE REVERSÃO (Se algo falhar)

```
Falha em Fase N na VM?
└─ Revert to Snapshot "After-Fase-(N-1)"
   └─ Recomeçar Fase N
      └─ Se falhar novamente:
         └─ Revert to "Base-Clean"
            └─ Recomeçar tudo (rápido em VM)

Falha na Migração?
└─ Máquina oficial:
   └─ Restaurar backup anterior
      └─ Ou reinstalar Ubuntu
         └─ E replicar novamente (scripts já testados)

Falha em Operação?
└─ Retorno à VM testada
   └─ Diagnosticar problema
      └─ Replicar fix na máquina oficial
```

---

## 📊 COMPARAÇÃO: VM vs Máquina Oficial

```
Aspecto          VM (Testes)              Máquina Oficial
─────────────────────────────────────────────────────────
Hardware         Virtualizado             Real
Recurso CPU      4 cores (compartilhado)  Completo disponível
Memória          8 GB (virtual)           Completa do hardware
Disco            50 GB (virtual)          Físico
Network          Bridge/NAT (VM)          Nativa
Performance      ~80% real                100% real
Snapshots        Disponíveis              Não (sem backup fácil)
Rollback         Trivial (segundos)       Requer restore (minutos)
Risco de teste   Zero (é só VM)           Baixo (testado em VM)
Dados            Isolados da máquina      Reais + críticos
```

---

## 📚 DOCUMENTAÇÃO RELACIONADA

- `planejamento.md` - Guia completo original
- `FASE-0.5-SETUP-VM-RAPIDO.md` - Setup passo a passo de VM
- `FASE6-CONEXAO-REMOTA-PERMANENTE.md` - Redes diferentes (futuro)
- `~/Linux-Admin-Project/docs/` - Documentação por fase

---

## 🎯 PRÓXIMO PASSO AGORA

```
1. ✅ Ler este documento
2. ⏳ Proceder para FASE 0 (Setup MacBook)
3. ⏳ Proceder para FASE 0.5 (Setup VM)
4. ⏳ Proceder para FASES 1-5 (Testes)
5. ⏳ Migração para máquina oficial

Tempo Total: 15-27 horas
Vantagem: Tudo testado e validado antes de ser "real"
```

---

**Criado:** 2026-09-28  
**Versão:** 1.0  
**Status:** Planejamento Completo - Pronto para Implementação
