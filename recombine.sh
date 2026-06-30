#!/usr/bin/env bash
# Récupération + recombinaison du GGUF Ornith 9B depuis la release GitHub.
# À lancer au boulot (Mac/Linux). Les parts passent le proxy via GitHub.
set -euo pipefail

# ponytail: URL codée en dur, repo temporaire supprimé après récup
REPO="joyearnaud/ornith-9b-ollama"
TAG="v1.0"

echo "→ Téléchargement des 3 parts depuis GitHub release $TAG..."
if command -v gh &>/dev/null; then
  gh release download "$TAG" --repo "$REPO" --pattern '*.part*' --clobber
else
  BASE="https://github.com/$REPO/releases/download/$TAG"
  for p in part0 part1 part2; do
    curl -L "$BASE/ornith-9b-q4_k_m.gguf.$p" -o "ornith-9b-q4_k_m.gguf.$p"
  done
fi

echo "→ Recombinaison du GGUF..."
cat ornith-9b-q4_k_m.gguf.part0 \
    ornith-9b-q4_k_m.gguf.part1 \
    ornith-9b-q4_k_m.gguf.part2 > ornith-9b-q4_k_m.gguf

echo "→ Création du modèle Ollama..."
ollama create ornith:9b -f Modelfile

echo "✓ Fait. Lance: ollama run ornith:9b"
