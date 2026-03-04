# PURE Assistant v0 — Skeleton

This folder contains the first generative layer on top of PURE.

It is a **local-only skeleton**:

- reads data from the SQLite database (`db/pure.db`)
- prepares structured context for the assistant
- loads a Semantic Kernel-based chat completion service (Azure OpenAI)
- uses a prompt template to answer questions about the portfolio

No API keys, endpoints or secrets are stored here.

---

## Components

- `db_access.py`  
  Small helper to read PUBLIC data from:
  - `v_portfolio_search_items`
  - `v_reflection_signals`

- `kernel_setup.py`  
  Skeleton to configure Semantic Kernel with an Azure OpenAI chat completion service.
  Reads configuration from environment variables:
  - `AZURE_OPENAI_ENDPOINT`
  - `AZURE_OPENAI_API_KEY`
  - `AZURE_OPENAI_DEPLOYMENT_NAME`

- `prompts/answer_about_portfolio.skprompt.txt`  
  Main semantic prompt for the assistant.
  It receives:
  - user question
  - structured context (JSON or text)
  and returns a Spanish, structured answer.

- `pure_assistant_cli.py`  
  Minimal CLI entry point to:
  - read a question from the terminal
  - fetch context from SQLite
  - call the kernel
  - print an answer

---

## What this is NOT

- It is not a production assistant.
- It does not implement RAG.
- It does not use semantic search or embeddings.
- It does not call any external systems beyond Azure OpenAI.

It is the **first generative layer** over a governed dataset.

---

## Usage

Full execution guide available at:

- docs/intelligence/pure-assistant-usage.md

This includes:

- dependency installation
- environment variable configuration
- CLI execution examples
- governance explanation