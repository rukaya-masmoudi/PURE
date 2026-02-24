# Azure AI Language → PURE Ingestion Contract

PURE does not call Azure AI Language directly.

Instead, it expects **offline outputs** (JSONL) to be ingested into:

- `ReflectionAnalysis`
- `ReflectionLabel` + `ReflectionLabelAssignment`

using:

- `tools/ingest_reflection_analysis.py`

---

## Data contract

Each line in the JSONL file must be a JSON object:

```jsonc
{
  "reflection_id": 1,
  "provider": "azure-ai-language",
  "language_code": "es",
  "sentiment": {
    "label": "positive",
    "positive": 0.86,
    "neutral": 0.11,
    "negative": 0.03
  },
  "key_phrases": [
    "Create Machine Learning Models",
    "base real de Machine Learning",
    "Azure"
  ],
  "category": "learning",
  "pii_flag": false,
  "visibility": "PUBLIC",
  "labels": [
    "learning-win",
    "learning-struggle"
  ]
}
```

## Field mapping
- reflection_id → ReflectionAnalysis.reflection_id
- provider → ReflectionAnalysis.provider
- language_code → ReflectionAnalysis.language_code
- sentiment.label → ReflectionAnalysis.sentiment_label
- sentiment.positive → ReflectionAnalysis.sentiment_positive
- sentiment.neutral → ReflectionAnalysis.sentiment_neutral
- sentiment.negative → ReflectionAnalysis.sentiment_negative
- key_phrases[] (array) → joined into ReflectionAnalysis.key_phrases
- category → ReflectionAnalysis.category
- pii_flag (bool) → ReflectionAnalysis.pii_flag (0/1)
- visibility (PUBLIC / PRIVATE) → ReflectionAnalysis.visibility_id
- labels[] (array of strings) → mapped via:
    - ReflectionLabel.name
    - ReflectionLabelAssignment

---

## Ingestion process
1.	Generate a JSONL file from your Azure AI Language workflow.
2.	Ensure the reflections already exist in the Reflection table.
3.	Run:

```bash
python tools/ingest_reflection_analysis.py .\data\azure-ai-language\YYYY-MM-DD_reflections_analysis.jsonl
```

4.	The script will:
- Delete existing ReflectionAnalysis rows for those reflections.
- Insert fresh ReflectionAnalysis rows.
- Ensure ReflectionLabel entries exist for all labels.
- Insert ReflectionLabelAssignment rows.

The process is idempotent:
- re-running ingestion with the same file replaces previous analysis and label assignments.

---

## How this relates to the Applied Skills

This contract mirrors the steps in:
- Build a natural language processing solution with Azure AI Language

PURE focuses on:
- modelling the domain,
- storing the signals,
- and making them queryable.

The actual calls to Azure AI Language live outside PURE, in a separate app or notebook that:
- reads reflections from PURE,
- calls Azure AI Language,
- writes JSONL outputs following this contract.