#!/bin/bash

# Script: Gerar Chaves SSH
# Objetivo: Criar par de chaves SSH para autenticação segura
# Uso: bash scripts/gen-ssh-keys.sh

echo "════════════════════════════════════════════════════════════"
echo "   GERADOR DE CHAVES SSH"
echo "════════════════════════════════════════════════════════════"
echo ""

PROJECT_DIR="$HOME/Linux-Admin-Project"
SSH_KEYS_DIR="$PROJECT_DIR/ssh-keys"
LOG_FILE="$PROJECT_DIR/logs/setup.log"

# Criar diretório de chaves
mkdir -p "$SSH_KEYS_DIR"
chmod 700 "$SSH_KEYS_DIR"

echo "📝 Configuração de Chaves SSH"
echo "─────────────────────────────────────────────────────────"
echo ""

# Obter informações do usuário
read -p "Nome do usuário admin no Ubuntu [admin_teste]: " ADMIN_USER
ADMIN_USER=${ADMIN_USER:-admin_teste}

read -p "Comentário para chave [admin@macbook]: " KEY_COMMENT
KEY_COMMENT=${KEY_COMMENT:-admin@macbook}

read -s -p "Passphrase para chave (deixe em branco para nenhuma): " PASSPHRASE
echo ""

echo ""
echo "🔑 Gerando chaves SSH..."
echo "─────────────────────────────────────────────────────────"

# Arquivo de saída
KEY_FILE="$SSH_KEYS_DIR/ubuntu_admin_key"

# Remover chaves antigas se existirem
if [ -f "$KEY_FILE" ]; then
    echo "⚠️ Chaves antigas encontradas. Fazendo backup..."
    mv "$KEY_FILE" "$KEY_FILE.old"
    mv "$KEY_FILE.pub" "$KEY_FILE.pub.old"
fi

# Gerar chaves
if [ -z "$PASSPHRASE" ]; then
    ssh-keygen -t ed25519 -f "$KEY_FILE" -N "" -C "$KEY_COMMENT"
else
    ssh-keygen -t ed25519 -f "$KEY_FILE" -N "$PASSPHRASE" -C "$KEY_COMMENT"
fi

# Verificar se deu certo
if [ $? -eq 0 ]; then
    echo ""
    echo "✅ Chaves geradas com sucesso!"
    echo ""
    echo "📂 Localização das chaves:"
    echo "   Private: $KEY_FILE"
    echo "   Public:  $KEY_FILE.pub"
    echo ""

    # Definir permissões
    chmod 600 "$KEY_FILE"
    chmod 644 "$KEY_FILE.pub"

    echo "🔒 Chave Privada (MANTER SEGURA):"
    echo "─────────────────────────────────────────────────────────"
    wc -l "$KEY_FILE"
    echo ""

    echo "🔓 Chave Pública (COPIAR PARA UBUNTU):"
    echo "─────────────────────────────────────────────────────────"
    cat "$KEY_FILE.pub"
    echo ""

    # Copiar chave pública para SSH padrão também (opcional)
    if [ ! -f "$HOME/.ssh/ubuntu_admin_key" ]; then
        cp "$KEY_FILE" "$HOME/.ssh/ubuntu_admin_key"
        cp "$KEY_FILE.pub" "$HOME/.ssh/ubuntu_admin_key.pub"
        echo "✅ Chaves copiadas para ~/.ssh/ também"
    fi

    echo ""
    echo "════════════════════════════════════════════════════════════"
    echo "✅ PRÓXIMOS PASSOS"
    echo "════════════════════════════════════════════════════════════"
    echo ""
    echo "1. Na Ubuntu VM, adicionar chave pública:"
    echo "   → mkdir -p ~/.ssh"
    echo "   → echo '$(cat $KEY_FILE.pub)' >> ~/.ssh/authorized_keys"
    echo "   → chmod 600 ~/.ssh/authorized_keys"
    echo ""
    echo "2. Testar conexão:"
    echo "   → ssh -i $KEY_FILE $ADMIN_USER@<ubuntu-ip>"
    echo ""
    echo "3. Usar em config SSH (já preparado em ~/.ssh/config):"
    echo "   → ssh ubuntu-direct  # Conexão direta"
    echo ""

    # Log
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] Chaves SSH geradas: $KEY_FILE" >> "$LOG_FILE"

else
    echo ""
    echo "❌ Erro ao gerar chaves!"
    exit 1
fi
