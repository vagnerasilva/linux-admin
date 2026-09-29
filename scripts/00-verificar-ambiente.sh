#!/bin/bash

# Script: Verificar Ambiente do MacBook
# Objetivo: Validar que MacBook tem tudo necessário para Fase 0
# Uso: bash scripts/00-verificar-ambiente.sh

echo "════════════════════════════════════════════════════════════"
echo "   VERIFICAÇÃO DE AMBIENTE - MacBook"
echo "════════════════════════════════════════════════════════════"
echo ""

# Cores para output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Inicializar contadores
TOTAL=0
PASS=0
WARN=0
FAIL=0

# Função para verificação
check() {
    local name="$1"
    local command="$2"
    TOTAL=$((TOTAL + 1))

    if eval "$command" &>/dev/null; then
        echo -e "${GREEN}✅${NC} $name"
        PASS=$((PASS + 1))
    else
        echo -e "${RED}❌${NC} $name"
        FAIL=$((FAIL + 1))
    fi
}

# Função para warning
warn() {
    local name="$1"
    local message="$2"
    TOTAL=$((TOTAL + 1))
    echo -e "${YELLOW}⚠️${NC} $name: $message"
    WARN=$((WARN + 1))
}

echo "📊 SISTEMA OPERACIONAL"
echo "─────────────────────────────────────────────────────────"
check "macOS versão" "sw_vers"
MACOS_VERSION=$(sw_vers -productVersion)
echo "   Versão: $MACOS_VERSION"
ARCH=$(uname -m)
echo "   Arquitetura: $ARCH"
echo ""

echo "🔧 FERRAMENTAS SSH (CRÍTICAS)"
echo "─────────────────────────────────────────────────────────"
check "OpenSSH instalado" "ssh -V"
check "scp disponível" "which scp"
check "sftp disponível" "which sftp"
check "ssh-keygen disponível" "which ssh-keygen"
SSH_DIR="$HOME/.ssh"
if [ -d "$SSH_DIR" ]; then
    echo -e "${GREEN}✅${NC} Diretório ~/.ssh existe"
    PASS=$((PASS + 1))
else
    echo -e "${YELLOW}⚠️${NC} Diretório ~/.ssh não existe (será criar)"
    WARN=$((WARN + 1))
fi
TOTAL=$((TOTAL + 1))
echo ""

echo "📦 HOMEBREW E GERENCIADOR DE PACOTES"
echo "─────────────────────────────────────────────────────────"
check "Homebrew instalado" "brew --version"
check "Git instalado" "git --version"
echo ""

echo "🖥️ TERMINAL"
echo "─────────────────────────────────────────────────────────"
check "Terminal.app" "[ -d '/Applications/Utilities/Terminal.app' ]"
if command -v iTerm &>/dev/null; then
    echo -e "${GREEN}✅${NC} iTerm2 instalado (opcional)"
    PASS=$((PASS + 1))
else
    echo -e "${YELLOW}⚠️${NC} iTerm2 não instalado (opcional)"
    WARN=$((WARN + 1))
fi
TOTAL=$((TOTAL + 1))
echo ""

echo "🌐 CONECTIVIDADE DE REDE"
echo "─────────────────────────────────────────────────────────"
check "Ping disponível" "which ping"
check "Traceroute disponível" "which traceroute"
check "Netcat disponível" "which nc"

# Obter IPs
LOCAL_IP=$(ifconfig | grep -E "inet " | grep -v 127.0.0.1 | grep -v 192.168.1 | head -1 | awk '{print $2}')
LAN_IP=$(ifconfig | grep -E "inet 192\." | head -1 | awk '{print $2}')

echo "   IP Local (LAN): ${LAN_IP:-Não encontrado}"
echo "   IP Externo: ${LOCAL_IP:-Não encontrado}"
echo ""

echo "🔑 REMOTE DESKTOP"
echo "─────────────────────────────────────────────────────────"
if [ -d "/Applications/Microsoft Remote Desktop.app" ]; then
    echo -e "${GREEN}✅${NC} Microsoft Remote Desktop instalado"
    PASS=$((PASS + 1))
else
    echo -e "${RED}❌${NC} Microsoft Remote Desktop NÃO instalado"
    echo "   → Instalar com: brew install microsoft-remote-desktop"
    FAIL=$((FAIL + 1))
fi
TOTAL=$((TOTAL + 1))
echo ""

echo "💾 ESPAÇO EM DISCO"
echo "─────────────────────────────────────────────────────────"
DISK_FREE=$(df -h / | tail -1 | awk '{print $4}')
DISK_TOTAL=$(df -h / | tail -1 | awk '{print $2}')
echo "   Espaço livre: $DISK_FREE / $DISK_TOTAL"

# Verificar se há espaço suficiente (60 GB para VM)
DISK_FREE_GB=$(df / | tail -1 | awk '{print $4/1024/1024}')
if (( $(echo "$DISK_FREE_GB > 60" | bc -l) )); then
    echo -e "${GREEN}✅${NC} Espaço suficiente para VM (>60 GB)"
    PASS=$((PASS + 1))
else
    echo -e "${YELLOW}⚠️${NC} Espaço limitado para VM (<60 GB)"
    WARN=$((WARN + 1))
fi
TOTAL=$((TOTAL + 1))
echo ""

echo "🗂️ ESTRUTURA DO PROJETO"
echo "─────────────────────────────────────────────────────────"
PROJECT_DIR="$HOME/Linux-Admin-Project"
if [ -d "$PROJECT_DIR" ]; then
    echo -e "${GREEN}✅${NC} Diretório do projeto existe: $PROJECT_DIR"
    PASS=$((PASS + 1))
else
    echo -e "${RED}❌${NC} Diretório do projeto não existe"
    FAIL=$((FAIL + 1))
fi
TOTAL=$((TOTAL + 1))

# Verificar subdirectórios
for dir in isos configs scripts ssh-keys backups logs docs; do
    if [ -d "$PROJECT_DIR/$dir" ]; then
        echo -e "${GREEN}✅${NC} $dir/"
        PASS=$((PASS + 1))
    else
        echo -e "${YELLOW}⚠️${NC} $dir/ não existe"
        WARN=$((WARN + 1))
    fi
    TOTAL=$((TOTAL + 1))
done
echo ""

echo "════════════════════════════════════════════════════════════"
echo "📊 RESUMO"
echo "════════════════════════════════════════════════════════════"
echo -e "✅ Passou: $PASS"
echo -e "${YELLOW}⚠️${NC}  Avisos: $WARN"
echo -e "${RED}❌${NC} Falhas: $FAIL"
echo "Total de Verificações: $TOTAL"
echo ""

if [ $FAIL -eq 0 ]; then
    echo -e "${GREEN}✅ AMBIENTE OK! Pronto para continuar.${NC}"
    echo ""
    echo "Próximos passos:"
    echo "1. Se Microsoft Remote Desktop não estiver instalado:"
    echo "   → brew install microsoft-remote-desktop"
    echo ""
    echo "2. Execute Fase 0.5 (Setup VM):"
    echo "   → Ver FASE-0.5-SETUP-VM-RAPIDO.md"
    exit 0
else
    echo -e "${RED}❌ PROBLEMAS ENCONTRADOS${NC}"
    echo ""
    echo "Ações necessárias:"
    if ! command -v brew &>/dev/null; then
        echo "• Instalar Homebrew: /bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\""
    fi
    if [ ! -d "/Applications/Microsoft Remote Desktop.app" ]; then
        echo "• Instalar Microsoft Remote Desktop: brew install microsoft-remote-desktop"
    fi
    echo ""
    echo "Depois de resolver, execute este script novamente."
    exit 1
fi
