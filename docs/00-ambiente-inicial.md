# Documentação: Ambiente Inicial

**Data:** 2026-09-28  
**Status:** Setup Inicial

---

## 📊 Status Atual do MacBook

### Informações do Sistema
```
macOS: 26.5.2 (Sequoia)
Build: 25F84
Arquitetura: arm64 (Apple Silicon)
Processador: Apple Silicon (M1/M2/M3/M4)
```

### Ferramentas Instaladas
- ✅ OpenSSH 10.2p1 (LibreSSL 3.3.6)
- ✅ Homebrew 7.0.4
- ✅ Git 2.50.1
- ✅ Terminal.app (nativo)
- ⏳ Microsoft Remote Desktop (será instalar)

### Conectividade de Rede
- ✅ IP Local (LAN): 192.168.0.63
- ✅ IP Externo: 54.232.189.113
- ✅ Wi-Fi ativo e funcional

---

## 🎯 Plano de Ação

### Fase 0: Preparação MacBook
- [ ] Instalar Microsoft Remote Desktop
- [ ] Criar estrutura de diretórios
- [ ] Preparar ambiente de desenvolvimento

**Tempo Estimado:** 2-4 horas

### Fase 0.5: Máquina Virtual
- [ ] Escolher e instalar hypervisor (Parallels/VMware/UTM)
- [ ] Baixar ISO Ubuntu 24.04 LTS arm64
- [ ] Criar VM com 4 CPU, 8 GB RAM, 50 GB Disk
- [ ] Instalar Ubuntu na VM
- [ ] Configurar rede da VM (Bridge mode)

**Tempo Estimado:** 2-3 horas

### Fases 1-5: Testes em VM
- [ ] Fase 1: Gerenciamento de contas
- [ ] Fase 2: DNS seguro
- [ ] Fase 3: Auditoria (auditd + Zeek)
- [ ] Fase 4: SSH + RDP
- [ ] Fase 5: RustDesk

**Tempo Estimado:** 9-16 horas

### Migração e Operação
- [ ] Validar todas as fases em VM
- [ ] Criar backup da VM
- [ ] Migrar para máquina oficial
- [ ] Testes de validação

**Tempo Estimado:** 1-2 horas cada

---

## 📁 Estrutura de Diretórios Criada

```
~/Linux-Admin-Project/
├── isos/                  ← ISO Ubuntu será baixada aqui
├── configs/               ← Arquivos de configuração
├── scripts/               ← Scripts executáveis
├── ssh-keys/              ← Chaves SSH (confidencial)
├── backups/               ← Backups de configuração
├── logs/                  ← Logs de execução
└── docs/                  ← Documentação
```

---

## 🔄 Próximos Passos

1. **Executar verificação de ambiente:**
   ```bash
   bash ~/Linux-Admin-Project/scripts/00-verificar-ambiente.sh
   ```

2. **Instalar ferramentas necessárias:**
   ```bash
   bash ~/Linux-Admin-Project/scripts/01-instalacoes.sh
   ```

3. **Ler documentação de VM:**
   ```bash
   cat ~/projetos_new/linux_project/FASE-0.5-SETUP-VM-RAPIDO.md
   ```

4. **Criar máquina virtual:**
   - Seguir [FASE-0.5-SETUP-VM-RAPIDO.md](../projetos_new/linux_project/FASE-0.5-SETUP-VM-RAPIDO.md)

---

## 📝 Notas

- VM será usada para testes antes de máquina oficial
- Snapshots permitem rollback rápido se algo falhar
- Todas as configurações testadas em VM antes de ir para produção
- Documentação atualizada ao final de cada fase

---

## 📞 Referências

- [planejamento.md](../linux_project/planejamento.md) - Guia completo
- [ROADMAP-VISUAL.md](../linux_project/ROADMAP-VISUAL.md) - Visão geral
- [FASE-0.5-SETUP-VM-RAPIDO.md](../linux_project/FASE-0.5-SETUP-VM-RAPIDO.md) - Setup VM

---

**Última Atualização:** 2026-09-28  
**Próxima Revisão:** Após Fase 0 concluída
