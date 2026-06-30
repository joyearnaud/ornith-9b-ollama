#!/usr/bin/env bash
# Déploie la config Ornith 9B pour pi et opencode (Mac/Linux).
# À lancer après recombine.sh, sur la machine où tourne Ollama.
set -euo pipefail
DIR="$(cd "$(dirname "$0")" && pwd)"

# 1. Pi : extension provider
mkdir -p ~/.pi/agent/extensions
cp "$DIR/pi-ollama-ornith.ts" ~/.pi/agent/extensions/
echo "✓ pi : extension dans ~/.pi/agent/extensions/pi-ollama-ornith.ts"
echo "  (dans pi : /reload, puis sélectionne ollama / ornith:9b)"

# 2. opencode : config provider (backup si existant)
mkdir -p ~/.config/opencode
if [ -f ~/.config/opencode/opencode.json ]; then
  cp ~/.config/opencode/opencode.json ~/.config/opencode/opencode.json.bak
  echo "⚠ opencode.json existant sauvegardé en .bak"
fi
cp "$DIR/opencode-config.json" ~/.config/opencode/opencode.json
echo "✓ opencode : config dans ~/.config/opencode/opencode.json"
echo "  (lance opencode, sélectionne Ollama / ornith:9b)"
