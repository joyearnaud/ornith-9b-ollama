# Ornith 9B (Q4_K_M) — GGUF pour Ollama

Modèle [Ornith 9B](https://ollama.com/library/ornith:9b) (arch qwen3.5, 8.95B params, Q4_K_M, 5.6 Go), découpé en 3 parts < 2 Go pour passer la limite GitHub.

## Au boulot (MacBook Air M4)

```bash
# 1. Cloner ce repo (Modelfile + scripts + configs agents)
gh repo clone joyearnaud/ornith-9b-ollama
cd ornith-9b-ollama

# 2. Télécharger les parts + recombiner + créer le modèle Ollama
./recombine.sh

# 3. Lancer en direct
ollama run ornith:9b

# 4. (optionnel) Brancher pi + opencode sur Ornith
./setup-agents.sh
```

## Vérification d'intégrité (optionnel)

```bash
# Le GGUF recombiné doit faire exactement 5 629 108 640 octets
stat -f%z ornith-9b-q4_k_m.gguf   # macOS
```

## Coding agents (pi + opencode)

`setup-agents.sh` déploie :
- **pi** : `pi-ollama-ornith.ts` → `~/.pi/agent/extensions/` (provider Ollama, modèle `ornith:9b`, contexte 64k). Dans pi : `/reload` puis sélectionne `ollama / ornith:9b`.
- **opencode** : `opencode-config.json` → `~/.config/opencode/opencode.json` (backup `.bak` si existant). Lance `opencode`, sélectionne `Ollama / ornith:9b`.

Contexte limité à 64k (vs 262k natif) pour garder marge RAM sur 16 Go. Coûts à 0 (modèle local).

## Notes

- License : MIT (Ornith-1.0 by deepreinforce-ai)
- Repo temporaire — supprimé après récupération
