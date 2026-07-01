import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";

// Provider Ornith 9B (Qwen3.5 arch) via Ollama local.
// Local model => coûts à 0. Contexte 64k : balance RAM / cache pour 9B Q4_K_M
// sur 16 Go RAM unifié M4. Doit matcher num_ctx dans le Modelfile,
// sinon Ollama tronque silencieusement à 2048.
export default function (pi: ExtensionAPI) {
  pi.registerProvider("ollama", {
    name: "Ollama (local)",
    baseUrl: "http://localhost:11434/v1",
    apiKey: "ollama", // requis par pi, Ollama ne vérifie pas
    api: "openai-completions",
    models: [
      {
        id: "ornith:9b",
        name: "Ornith 9B",
        reasoning: false,
        input: ["text"],
        cost: { input: 0, output: 0, cacheRead: 0, cacheWrite: 0 },
        contextWindow: 65536,
        maxTokens: 8192,
      },
    ],
  });
}
