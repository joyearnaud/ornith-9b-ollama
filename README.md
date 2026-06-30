# Ornith 9B (Q4_K_M) — GGUF pour Ollama

Modèle [Ornith 9B](https://ollama.com/library/ornith:9b) (arch qwen3.5, 8.95B params, Q4_K_M, 5.6 Go), découpé en 3 parts < 2 Go pour passer la limite GitHub.

## Au boulot (MacBook Air M4)

```bash
# 1. Cloner ce repo (récupère Modelfile + recombine.sh)
gh repo clone joyearnaud/ornith-9b-ollama
cd ornith-9b-ollama

# 2. Télécharger les parts + recombiner + créer le modèle Ollama
./recombine.sh

# 3. Lancer
ollama run ornith:9b
```

## Vérification d'intégrité (optionnel)

```bash
# Le GGUF recombiné doit faire exactement 5 629 108 640 octets
stat -f%z ornith-9b-q4_k_m.gguf   # macOS
```

## Notes

- License : MIT (Ornith-1.0 by deepreinforce-ai)
- Repo temporaire — supprimé après récupération
