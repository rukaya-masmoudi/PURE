# Generative Layer — PURE Assistant v0 (Design)

PURE Assistant v0 is the first generative layer
built on top of the existing structured system.

It does not replace structure.
It consumes structure.

This document defines:

- architecture
- boundaries
- responsibilities
- governance rules

No Azure resources are created at this stage.
This is a design specification only.

---

# 1. Purpose

PURE Assistant v0 allows a user to:

- ask about my professional trajectory
- ask about events
- ask about studies
- ask about reflections and growth
- receive a structured, contextual response

The assistant does NOT:

- modify data
- access private items
- call external systems dynamically
- use embeddings or vector search

It operates on top of:

- SQL queries
- curated prompts
- Azure OpenAI
- Semantic Kernel orchestration

---

# 2. Architecture Overview

User Question
      ↓
Query Router (logical layer)
      ↓
SQL Query (against SQLite PURE db)
      ↓
Structured Result Set
      ↓
Prompt Template (Semantic Kernel)
      ↓
Azure OpenAI (Chat Completion)
      ↓
Generated Response

PURE remains the source of truth.
The LLM is only a formatter and synthesizer.

---

# 3. Data Sources Used

PURE Assistant v0 can read from:

- `v_portfolio_search_items`
- `v_reflection_signals`
- `v_day_metrics`
- `v_ml_study_sessions`
- `Engagement`
- `Event`
- `Topic`

All data must already be:

- PUBLIC
- structured
- governed

The assistant never queries raw PRIVATE tables.

---

# 4. Functional Capabilities

### 4.1 Trajectory questions

Examples:

- "What has Rukaya been doing in 2026?"
- "Summarize her community impact."
- "What kind of events does she attend?"

Mechanism:

- SQL filtered by date / itemType
- Prompt synthesizes narrative

---

### 4.2 Learning evolution

Examples:

- "How has her learning evolved?"
- "What are her main ML topics?"
- "What reflections show growth?"

Mechanism:

- Query `Topic`, `StudySession`, `Reflection`
- Provide structured summary
- Prompt transforms into explanation

---

### 4.3 Reflection-based insight

Examples:

- "What themes appear in her reflections?"
- "Does she show career clarity?"

Mechanism:

- Query `ReflectionAnalysis`
- Query `ReflectionLabel`
- Aggregate in SQL
- LLM summarizes patterns

---

# 5. Semantic Kernel Role

Semantic Kernel is used as:

- Prompt orchestrator
- Template manager
- Function abstraction layer

Not used for:

- planning agents
- autonomous decision making
- tool recursion
- memory storage

At this stage, SK simply:

1. Accepts structured data.
2. Injects it into a controlled template.
3. Calls Azure OpenAI.
4. Returns response.

---

# 6. Prompt Governance

Every prompt must:

- State that data comes from structured PURE system.
- Avoid hallucinating missing data.
- Explicitly instruct model:
  - "If information is missing, say so."
- Never fabricate events, roles or certifications.

Tone rules:

- Professional.
- Structured.
- Honest.
- No exaggeration.

---

# 7. Security & Boundaries

- Only PUBLIC data is queried.
- No PII reflections should be passed to the model.
- If `pii_flag = 1`, that reflection is excluded.
- No write operations allowed.
- No external browsing.

PURE Assistant v0 is read-only.

---

# 8. Why this design matters

This design demonstrates:

- Clear separation between:
  - data
  - search
  - generation
- LLM as reasoning layer, not source of truth.
- Governance before generation.
- Architecture before implementation.

This reflects the mindset required for:

- enterprise AI systems
- responsible generative AI
- hybrid structured + generative solutions

## Implementation skeleton

The first implementation artefacts for PURE Assistant v0 live in:

- assistant/:
  - db_access.py — reads PUBLIC data from SQLite
  - kernel_setup.py — configures Semantic Kernel with Azure OpenAI
  - prompts/answer_about_portfolio.skprompt.txt — main semantic prompt
  - pure_assistant_cli.py — minimal CLI entry point

They are kept intentionally simple and local-only.
No deployment or infrastructure is defined at this stage.