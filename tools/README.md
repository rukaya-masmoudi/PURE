# Tools

Small utilities to keep PURE reproducible locally.

## build_db.py

Creates a fresh local SQLite database (`db/pure.db`) from:

- `db/schema.sql`
- `db/seed.sql`

### Requirements

- Python 3.x

### Run

From the repo root:

```bash
python tools/build_db.py
```

## ingest_reflection_analysis.py

Offline ingestion tool for Azure AI Language outputs.

It expects a JSONL file where each line contains:

- One reflection analysis result, including:
  - `reflection_id`
  - `sentiment` (label + scores)
  - `key_phrases`
  - `category`
  - `pii_flag`
  - `visibility`
  - `labels` (for multi-label classification)

The JSONL contract is documented in:

- `docs/intelligence/azure-ai-language-ingestion.md`

### Requirements

- Python 3.x
- A built local database (`pure.db`) in the repository root

If `pure.db` does not exist yet, create it first with:

```bash
python tools/build_db.py
```

### Run

From the repository root:

```bash
python tools/ingest_reflection_analysis.py data/azure-ai-language/2026-02-23_reflections_analysis.jsonl
```

This will:

- Delete any existing `ReflectionAnalysis` rows for the given reflections
- Delete existing `ReflectionLabelAssignment` rows for those reflections
- Insert fresh analysis rows
- Ensure labels exist in `ReflectionLabel`
- Insert label assignments in `ReflectionLabelAssignment`