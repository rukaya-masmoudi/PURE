# Azure AI Language artifacts

This folder stores offline outputs from Azure AI Language
used to populate:

- `ReflectionAnalysis`
- `ReflectionLabel`
- `ReflectionLabelAssignment`

Files are **not** tracked by git.

## Naming convention

Use one file per ingestion batch:

- `YYYY-MM-DD_reflections_analysis.jsonl`
- `YYYY-MM-DD_reflections_analysis_v2.jsonl` (if you re-run analysis on a later date)

Each file must follow the contract described in:

- `docs/intelligence/azure-ai-language-ingestion.md`