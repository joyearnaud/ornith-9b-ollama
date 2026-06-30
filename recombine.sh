#!/usr/bin/env bash
# Récupération + recombinaison du GGUF Ornith 9B depuis la release GitHub.
# À lancer au boulot (Mac/Linux). Les parts passent le proxy via GitHub.
set -euo pipefail

# ponytail: URL codée en dur, repo temporaire supprimé après récup
REPO="joyearnaud/ornith-9b-ollama"
TAG="v1.0"

# ponytail: download // sur MacBook Air M4 (fibre derrière proxy), divise le tps par ~3
echo "→ Téléchargement parallèle des 3 parts depuis GitHub release $TAG..."
if command -v gh &>/dev/null; then
  gh release download "$TAG" --repo "$REPO" --pattern '*.part*' --clobber
else
  BASE="https://github.com/$REPO/releases/download/$TAG"
  for p in part0 part1 part2; do
    curl -L "$BASE/ornith-9b-q4_k_m.gguf.$p" -o "ornith-9b-q4_k_m.gguf.$p" &
  done
  wait
fi

echo "→ Recombinaison du GGUF..."
cat ornith-9b-q4_k_m.gguf.part0 \
    ornith-9b-q4_k_m.gguf.part1 \
    ornith-9b-q4_k_m.gguf.part2 > ornith-9b-q4_k_m.gguf

# Vérif d'intégrité : taille exacte attendue (5629108640 octets)
# ponytail: stat -f%z (macOS) avec fallback -c%s (Linux)
SIZE=$(stat -f%z ornith-9b-q4_k_m.gguf 2>/dev/null || stat -c%s ornith-9b-q4_k_m.gguf)
if [ "$SIZE" != "5629108640" ]; then
  echo "✗ Taille incorrecte ($SIZE != 5629108640). Téléchargement corrompu."
  exit 1
fi

echo "→ Démarrage d'Ollama si nécessaire..."
# open -a Ollama = macOS app ; fallback ollama serve = install brew sans l'app
if ! ollama list &>/dev/null; then
  open -a Ollama 2>/dev/null || ollama serve >/dev/null 2>&1 &
  sleep 3
fi

echo "→ Création du modèle Ollama..."
ollama create ornith:9b -f Modelfile

echo "✓ Fait. Lance: ollama run ornith:9b"
