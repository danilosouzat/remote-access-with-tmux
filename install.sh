#!/usr/bin/env bash
set -e

CLI_NAME="meuprojetoctl"
INSTALL_PATH="/usr/local/bin/$CLI_NAME"

echo "🚀 Instalando $CLI_NAME..."

# Verifica se está rodando como sudo
if [[ "$EUID" -ne 0 ]]; then
  echo "❌ Execute como sudo:"
  echo "sudo bash install.sh"
  exit 1
fi

# Verifica dependências
echo "🔍 Verificando dependências..."

command -v ssh >/dev/null || { echo "❌ ssh não instalado"; exit 1; }
command -v tmux >/dev/null || { echo "❌ tmux não instalado"; exit 1; }

echo "✅ Dependências OK"

# Baixa script principal do GitHub
echo "⬇️ Baixando $CLI_NAME..."

curl -fsSL https://github.com/danilosouzat/remote-access-with-tmux.git -o "$INSTALL_PATH"

# Permissão de execução
chmod +x "$INSTALL_PATH"

echo "✅ Instalado em $INSTALL_PATH"

# Instalar autocomplete
echo "⚙️ Instalando autocomplete..."

COMPLETION_SCRIPT="$($CLI_NAME completion)"

echo "$COMPLETION_SCRIPT" > /etc/bash_completion.d/$CLI_NAME

echo "✅ Autocomplete configurado"

# Final
echo
echo "🎉 Instalação concluída!"
echo
echo "👉 Teste com:"
echo "   $CLI_NAME help"
echo
echo "⚠️ Lembre-se de configurar:"
echo "   sudo nano $INSTALL_PATH"
echo
echo "👉 Edite:"
echo "   REMOTE_HOST"
echo "   APP_DIR"
echo "   GEMSET"
echo