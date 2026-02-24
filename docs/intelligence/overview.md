# Intelligence Layer — Overview

The Intelligence layer in PURE does not start with agents or RAG.

It starts with **Signal Intelligence v1**:
turning language into signals that can be stored, queried and governed.

This document explains what is active today and what is explicitly out of scope.

---

## What exists today (Signal Intelligence v1)

### 1. Reflections & NLP signals

Reflections are short or long-form texts about:

- study sessions
- events
- career engagements
- other moments

They are stored in:

- `Reflection`
- `ReflectionAnalysis`
- `ReflectionLabel`
- `ReflectionLabelAssignment`

Signals captured:

- sentiment:
  - label (positive / neutral / negative / mixed)
  - scores (positive, neutral, negative)
- key phrases:
  - extracted phrases stored as a simple comma-separated string
- category:
  - high-level category such as learning, community, career
- PII flag:
  - whether the text contains sensitive content (boolean)
- labels:
  - multi-label classification (learning-win, learning-struggle, community-pride, career-clarity, identity-purpose, ...)

Public reflections and their signals are exposed through:

- `v_reflection_signals`

and explored with:

- `16_reflections_latest.sql`
- `17_reflections_search.sql`
- `18_reflections_by_category_sentiment.sql`
- `22_reflection_labels_overview.sql`
- `23_reflections_by_label.sql`
- `24_reflection_label_matrix.sql`

---

### 2. Portfolio Search base (unified view)

The Intelligence layer also defines the **search surface** of PURE.

The view:

- `v_portfolio_search_items`

unifies:

- study topics (Studies)
- events (Life)
- career engagements (Career & Roles)
- contributions (talks, panels, workshops)
- reflections (with sentiment and categories)

and makes them queryable through:

- `19_portfolio_all_items.sql`
- `20_portfolio_search_by_text.sql`
- `21_portfolio_filter_by_type.sql`

This view is the logical base for future:

- search experiences
- Azure AI Search indexes
- assistants built on top of PURE

---

### 3. Azure AI Language ingestion (offline)

PURE does not call Azure AI Language directly.

Instead, it expects **offline outputs** (JSONL) to be produced by an external workflow and stored under:

- `data/azure-ai-language/`

The contract is defined in:

- `docs/intelligence/azure-ai-language-ingestion.md`

Ingestion is performed by:

- `tools/ingest_reflection_analysis.py`

which populates:

- `ReflectionAnalysis`
- `ReflectionLabel`
- `ReflectionLabelAssignment`

in an idempotent way.

---

## What a non-technical viewer can understand

From the Intelligence layer today, a non-technical viewer should be able to see that:

- PURE does not just store “what happens”.
- It also stores **how it feels** and **what it means**:
  - learning wins and struggles
  - community moments
  - career clarity
  - reflections about identity and purpose

and that all of this is:

- structured
- queryable
- and governed

---

## What is intentionally NOT implemented yet

The following topics are explicitly out of scope at this stage:

- RAG over PURE data
- vector embeddings
- assistants or chat interfaces on top of PURE
- full-text indexing and semantic search
- multi-modal analysis beyond text

These capabilities belong to later phases of the Intelligence roadmap.

Signal Intelligence v1 focuses on:

- modelling
- storing
- and querying

signals from language, using the concepts learned in:

- *Build a natural language processing solution with Azure AI Language*

without embedding cloud calls or agents into the repository.