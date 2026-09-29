#!/bin/bash

# Script: Instalar Ferramentas Necessárias (Fase 0)
# Objetivo: Instalar Microsoft Remote Desktop e dependências
# Uso: bash scripts/01-instalacoes.sh

echo "════════════════════════════════════════════════════════════"
echo "   FASE 0: INSTALAÇÕES - MacBook"
echo "════════════════════════════════════════════════════════════"
echo ""

PROJECT_DIR="$HOME/Linux-Admin-Project"
LOG_FILE="$PROJECT_DIR/logs/setup.log"

# Criar log
mkdir -p "$PROJECT_DIR/logs"
echo "[$(date '+%Y-%m-%d %H:%M:%S')] FASE 0: Instalações iniciadas" >> "$LOG_FILE"

# Cores
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo "🔧 Verificando Homebrew..."
if ! command -v brew &>/dev/null; then
    echo "❌ Homebrew não instalado. Instalando..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] Homebrew instalado" >> "$LOG_FILE"
else
    echo -e "${GREEN}✅${NC} Homebrew já instalado"
fi
echo ""

echo "📦 Atualizando Homebrew..."
brew update
echo "[$(date '+%Y-%m-%d %H:%M:%S')] Homebrew atualizado" >> "$LOG_FILE"
echo ""

echo "🖥️ Instalando Microsoft Remote Desktop..."
if ! [ -d "/Applications/Microsoft Remote Desktop.app" ]; then
    brew install microsoft-remote-desktop
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] Microsoft Remote Desktop instalado" >> "$LOG_FILE"
    echo -e "${GREEN}✅${NC} Microsoft Remote Desktop instalado com sucesso"
else
    echo -e "${GREEN}✅${NC} Microsoft Remote Desktop já instalado"
fi
echo ""

echo "🌐 Instalando ferramentas de rede úteis (opcional)..."
# Instalar ferramentas adicionais úteis
TOOLS_TO_INSTALL=(
    "nmap"      # Network scanning
    "telnet"    # Basic connectivity tests
    "wget"      # File download
    "curl"      # File download
)

for tool in "${TOOLS_TO_INSTALL[@]}"; do
    if ! command -v "$tool" &>/dev/null; then
        echo "  Instalando $tool..."
        brew install "$tool" 2>/dev/null || echo "  ⚠️ $tool installation optional"
    else
        echo "  ✅ $tool já instalado"
    fi
done
echo "[$(date '+%Y-%m-%d %H:%M:%S')] Ferramentas de rede instaladas" >> "$LOG_FILE"
echo ""

echo "🔑 Criando estrutura de diretórios SSH..."
mkdir -p "$HOME/.ssh"
chmod 700 "$HOME/.ssh"
echo "[$(date '+%Y-%m-%d %H:%M:%S')] Diretório ~/.ssh criado" >> "$LOG_FILE"
echo ""

echo "📝 Criar ~/.ssh/config para facilitar conexões..."
if [ ! -f "$HOME/.ssh/config" ]; then
    cat > "$HOME/.ssh/config" << 'EOF'
# Linux Admin Project SSH Configurations

# Ubuntu via SSH direto
Host ubuntu-direct
    HostName 192.168.0.100
    Port 2222
    User admin_teste
    IdentityFile ~/.ssh/ubuntu_admin_key
    StrictHostKeyChecking no
    UserKnownHostsFile=/dev/null

# Ubuntu via SSH Tunnel (para redes diferentes)
Host ubuntu-tunnel
    HostName localhost
    Port 2223
    User admin_teste
    IdentityFile ~/.ssh/ubuntu_admin_key
    StrictHostKeyChecking no
    UserKnownHostsFile=/dev/null

# Adicionar mais hosts conforme necessário
EOF
    chmod 600 "$HOME/.ssh/config"
    echo -e "${GREEN}✅${NC} ~/.ssh/config criado"
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] ~/.ssh/config criado" >> "$LOG_FILE"
else
    echo "⚠️ ~/.ssh/config já existe (pulando)"
fi
echo ""

echo "💾 Criar diretório de backups..."
mkdir -p "$PROJECT_DIR/backups"
echo -e "${GREEN}✅${NC} Diretório de backups pronto"
echo ""

echo "📊 Configuração do Git (para rastrear mudanças)..."
if [ -d "$PROJECT_DIR/.git" ]; then
    echo "⚠️ Git já inicializado neste diretório"
else
    cd "$PROJECT_DIR"
    git init
    git config user.name "Linux Admin"
    git config user.email "admin@linux-project"
    echo "README.md" > .gitignore
    echo "ssh-keys/" >> .gitignore
    echo "*.log" >> .gitignore
    echo "backups/" >> .gitignore
    git add .gitignore
    git commit -m "Initial commit: Linux Admin Project structure"
    echo -e "${GREEN}✅${NC} Git inicializado"
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] Git repositório inicializado" >> "$LOG_FILE"
fi
echo ""

echo "════════════════════════════════════════════════════════════"
echo "✅ FASE 0 CONCLUÍDA"
echo "════════════════════════════════════════════════════════════"
echo ""
echo "Status:"
echo "  ✅ Homebrew atualizado"
echo "  ✅ Microsoft Remote Desktop instalado"
echo "  ✅ Ferramentas de rede instaladas"
echo "  ✅ Estrutura de diretórios preparada"
echo "  ✅ SSH config preparado"
echo "  ✅ Git inicializado"
echo ""
echo "📝 Log salvo em: $LOG_FILE"
echo ""
echo "Próximos passos:"
echo "1. Verificar ambiente: bash scripts/00-verificar-ambiente.sh"
echo "2. Ir para Fase 0.5: Criar máquina virtual"
echo "   → Ver FASE-0.5-SETUP-VM-RAPIDO.md"
echo ""
echo "[$(date '+%Y-%m-%d %H:%M:%S')] FASE 0: Instalações concluídas" >> "$LOG_FILE"
