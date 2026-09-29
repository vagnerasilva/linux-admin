#!/bin/bash

# Script: Verificar Status de Conexão
# Objetivo: Testar conectividade SSH, RDP e RustDesk
# Uso: bash scripts/check-connection.sh

PROJECT_DIR="$HOME/Linux-Admin-Project"
LOG_FILE="$PROJECT_DIR/logs/connection-monitor.log"

# Cores
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Configurações (customizar conforme necessário)
UBUNTU_HOST="192.168.0.100"  # Mudar para IP/hostname da Ubuntu
UBUNTU_PORT="2222"
UBUNTU_USER="admin_teste"
KEY_FILE="$PROJECT_DIR/ssh-keys/ubuntu_admin_key"

echo "════════════════════════════════════════════════════════════"
echo "   VERIFICAÇÃO DE CONECTIVIDADE"
echo "════════════════════════════════════════════════════════════"
echo ""
echo "[$(date '+%Y-%m-%d %H:%M:%S')] Iniciando testes..." >> "$LOG_FILE"
echo ""

# Teste 1: Ping
echo "🌐 Teste 1: Ping"
echo "─────────────────────────────────────────────────────────"
if ping -c 1 -W 2 "$UBUNTU_HOST" &>/dev/null; then
    echo -e "${GREEN}✅${NC} Ping OK: $UBUNTU_HOST responde"
    PING_STATUS="OK"
else
    echo -e "${RED}❌${NC} Ping FALHA: $UBUNTU_HOST não responde"
    PING_STATUS="FALHA"
fi
echo ""

# Teste 2: SSH
echo "🔐 Teste 2: SSH"
echo "─────────────────────────────────────────────────────────"
if [ -f "$KEY_FILE" ]; then
    if timeout 5 ssh -o ConnectTimeout=5 -p "$UBUNTU_PORT" -i "$KEY_FILE" "$UBUNTU_USER@$UBUNTU_HOST" "echo 'SSH Test OK'" &>/dev/null; then
        echo -e "${GREEN}✅${NC} SSH OK: Conectou com sucesso"
        SSH_STATUS="OK"
    else
        echo -e "${RED}❌${NC} SSH FALHA: Não conseguiu conectar"
        SSH_STATUS="FALHA"
    fi
else
    echo -e "${YELLOW}⚠️${NC} SSH: Chave não encontrada em $KEY_FILE"
    SSH_STATUS="CHAVE_AUSENTE"
fi
echo ""

# Teste 3: RDP
echo "🖥️ Teste 3: RDP"
echo "─────────────────────────────────────────────────────────"
if timeout 5 nc -zv "$UBUNTU_HOST" 3389 &>/dev/null; then
    echo -e "${GREEN}✅${NC} RDP OK: Porta 3389 está aberta"
    RDP_STATUS="OK"
else
    echo -e "${YELLOW}⚠️${NC} RDP: Porta 3389 não está respondendo"
    RDP_STATUS="INDISPONIVEL"
fi
echo ""

# Teste 4: RustDesk
echo "🎮 Teste 4: RustDesk"
echo "─────────────────────────────────────────────────────────"
if pgrep -x "RustDesk" &>/dev/null; then
    echo -e "${GREEN}✅${NC} RustDesk: Rodando no MacBook"
    RUSTDESK_STATUS="RODANDO"
else
    echo -e "${YELLOW}⚠️${NC} RustDesk: Não está rodando no MacBook"
    RUSTDESK_STATUS="PARADO"
fi
echo ""

# Teste 5: DNS
echo "🌐 Teste 5: DNS (Dynamic DNS - se configurado)"
echo "─────────────────────────────────────────────────────────"
DDNS_HOST="ubuntu.no-ip.biz"  # Customizar conforme necessário
if nslookup "$DDNS_HOST" &>/dev/null; then
    RESOLVED_IP=$(nslookup "$DDNS_HOST" | grep -A1 "Name:" | tail -1 | awk '{print $2}')
    echo -e "${GREEN}✅${NC} DNS OK: $DDNS_HOST → $RESOLVED_IP"
    DNS_STATUS="OK"
else
    echo -e "${YELLOW}⚠️${NC} DNS: $DDNS_HOST não resolve (DDNS pode não estar configurado)"
    DNS_STATUS="INDISPONIVEL"
fi
echo ""

# Resumo
echo "════════════════════════════════════════════════════════════"
echo "📊 RESUMO"
echo "════════════════════════════════════════════════════════════"
echo ""
echo "Ping:        $PING_STATUS"
echo "SSH:         $SSH_STATUS"
echo "RDP:         $RDP_STATUS"
echo "RustDesk:    $RUSTDESK_STATUS"
echo "DNS (DDNS):  $DNS_STATUS"
echo ""

# Log
echo "[$(date '+%Y-%m-%d %H:%M:%S')] RESULTADO: Ping=$PING_STATUS SSH=$SSH_STATUS RDP=$RDP_STATUS RustDesk=$RUSTDESK_STATUS DNS=$DNS_STATUS" >> "$LOG_FILE"

# Recomendações
echo "💡 RECOMENDAÇÕES"
echo "─────────────────────────────────────────────────────────"

if [ "$PING_STATUS" = "FALHA" ]; then
    echo "❌ Ping falhou:"
    echo "   - Verificar se Ubuntu está ligada"
    echo "   - Verificar conexão de rede"
    echo "   - Verificar firewall"
fi

if [ "$SSH_STATUS" = "FALHA" ]; then
    echo "❌ SSH falhou:"
    echo "   - Verificar se SSH server está rodando em Ubuntu"
    echo "   - Verificar firewall/regras de entrada"
    echo "   - Verificar porta SSH (padrão 2222)"
fi

if [ "$SSH_STATUS" = "CHAVE_AUSENTE" ]; then
    echo "❌ Chave SSH não encontrada:"
    echo "   - Gerar chaves: bash scripts/gen-ssh-keys.sh"
fi

if [ "$RDP_STATUS" = "INDISPONIVEL" ]; then
    echo "❌ RDP não disponível:"
    echo "   - RDP talvez não esteja instalado em Ubuntu"
    echo "   - Ver Fase 4: SSH + RDP"
fi

if [ "$RUSTDESK_STATUS" = "PARADO" ]; then
    echo "❌ RustDesk não está rodando:"
    echo "   - Iniciar RustDesk manualmente no MacBook"
fi

echo ""
echo "Logs completos em: $LOG_FILE"
