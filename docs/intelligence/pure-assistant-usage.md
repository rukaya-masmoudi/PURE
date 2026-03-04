# PURE Assistant v0 — Usage Guide

PURE Assistant v0 is a local-only, read-only generative layer.

It uses:

- SQLite database (`db/pure.db`)
- Semantic Kernel (Python)
- Azure OpenAI (Chat Completion)

It never modifies data.
It never accesses PRIVATE items.
It only consumes structured PUBLIC data.

---

# 1. Requirements

- Python 3.10+
- `semantic-kernel` package installed
- An Azure OpenAI resource
- A deployed chat model

---

# 2. Install dependencies

From the repository root:

```bash
python -m pip install semantic-kernel python-dotenv
```

---

# 3. Environment variables

Set the following environment variables in your system:

- AZURE_OPENAI_ENDPOINT
- AZURE_OPENAI_API_KEY
- AZURE_OPENAI_DEPLOYMENT_NAME

Example (PowerShell):

```bash
AZURE_OPENAI_ENDPOINT "https://your-resource.openai.azure.com/"
AZURE_OPENAI_API_KEY "your-api-key"
AZURE_OPENAI_DEPLOYMENT_NAME "gpt-4o"
```

Restart the terminal after setting them.

No secrets are stored in the repository.

---

# 4. Build the database

If not already built:

```bash
python tools/build_db.py
```

This ensures `db/pure.db` exists at repository root.

---

# 5. Run PURE Assistant v0

From the repository root:

```bash
python -m assistant.pure_assistant_cli "¿Qué está intentando demostrar PURE exactamente?"
```

Or run without argument and type interactively:

```bash
python -m assistant.pure_assistant_cli
```

---

# 6. Example questions

- "¿Qué tipo de eventos suelo asistir?"
- "¿Qué señales aparecen en mis reflexiones recientes?"
- "Resume mi impacto en comunidades tecnológicas."
- "¿Cómo ha evolucionado mi aprendizaje en machine learning?"

---

# 7. Governance model

PURE Assistant v0:

- Queries only PUBLIC data.
- Uses:
  - `v_portfolio_search_items`
  - `v_reflection_signals`
- Does not:
  - write to database
  - modify records
  - fabricate missing items (prompt instructed not to hallucinate)

If data is missing, the assistant will explicitly say so.

---

# 8. Known limitations (v0)

- No embeddings.
- No semantic search.
- No vector database.
- No RAG.
- No conversation memory.
- No multi-turn context persistence.

This is intentional.

PURE Assistant v0 demonstrates:

- Structured → Generative integration
- Governance-first design
- Semantic Kernel orchestration
- Responsible generative AI principles

Future phases will extend this foundation.