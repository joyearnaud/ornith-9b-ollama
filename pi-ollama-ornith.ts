import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";

// Provider Ornith 9B (Qwen3.5 arch) via Ollama local.
// Local model => coûts à 0. Contexte 32k pour rester safe sur 16 Go RAM.
// thinkingFormat "qwen-chat-template" : serveur local Qwen-compatible,
// lit chat_template_kwargs.enable_thinking et preserve_thinking.
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
        reasoning: true,
        input: ["text"],
        cost: { input: 0, output: 0, cacheRead: 0, cacheWrite: 0 },
        contextWindow: 32768,
        maxTokens: 8192,
        compat: { thinkingFormat: "qwen-chat-template" },
      },
    ],
  });
}
