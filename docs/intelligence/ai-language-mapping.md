# Azure AI Language → PURE Mapping

This document maps the concepts from:

- *Build a natural language processing solution with Azure AI Language*

to concrete tables, views, queries and tools inside PURE.

The goal is to show that PURE is not a demo script,
but a governed system that can host the outputs of a real NLP solution.

---

## 1. Input texts and domain

### Azure AI Language concept

- Input documents to be analysed:
  - user feedback
  - comments
  - support tickets
  - etc.

### PURE equivalent

PURE uses **Reflections** as the main NLP input surface:

- `Reflection`:
  - `source_type`:
    - STUDY        → `StudySession.session_id`
    - EVENT        → `Event.event_id`
    - WORK         → `Engagement.engagement_id` (work)
    - EDUCATION    → `Engagement.engagement_id` (education)
    - VOLUNTEERING → `Engagement.engagement_id` (volunteering)
    - OTHER        → not linked to a specific entity
  - `source_id`:
    - the actual id referenced according to `source_type`
  - `created_at`:
    - when the reflection was written
  - `text`:
    - the content to be analysed
  - `visibility_id`:
    - PUBLIC / PRIVATE

This lets PURE connect each NLP signal back to:

- what was studied
- which event happened
- which job or volunteering role it relates to

---

## 2. Sentiment analysis

### Azure AI Language concept

- Sentiment analysis:
  - document-level label (positive / neutral / negative / mixed)
  - confidence scores per class
  - language code

### PURE equivalent

- `ReflectionAnalysis`:
  - `sentiment_label`
  - `sentiment_positive`
  - `sentiment_neutral`
  - `sentiment_negative`
  - `language_code`
  - `provider` (usually `azure-ai-language`)

- `v_reflection_signals`:
  - exposes public reflections with their sentiment label and scores.

Key queries:

- `16_reflections_latest.sql`
  - see latest reflections with sentiment.
- `18_reflections_by_category_sentiment.sql`
  - aggregate reflections per category and sentiment.
- `24_reflection_label_matrix.sql`
  - matrix of labels and sentiment labels.

---

## 3. Key phrase extraction

### Azure AI Language concept

- Key phrase extraction:
  - list of relevant phrases per document.

### PURE equivalent

- `ReflectionAnalysis.key_phrases`:
  - stored as a comma-separated list (simple but inspectable).

- `v_reflection_signals`:
  - exposes `key_phrases` for public reflections.

This is enough to:

- inspect the phrases detected by Azure AI Language,
- use them in manual analysis or external notebooks.

If a more structured representation is needed in the future,
PURE can evolve to:

- a separate `KeyPhrase` table
- a link table between `Reflection` and `KeyPhrase`.

For Signal Intelligence v1, a single text field is sufficient.

---

## 4. Text classification and categories

### Azure AI Language concept

- Text classification:
  - assign documents to categories
  - sometimes hierarchies or multiple labels

### PURE equivalent

PURE distinguishes between:

1. A simple category coming from the service:

   - `ReflectionAnalysis.category`:
     - a high-level category such as:
       - learning
       - community
       - career

2. A **multi-label taxonomy owned by PURE**:

   - `ReflectionLabel`:
     - catalog of labels such as:
       - learning-win
       - learning-struggle
       - community-pride
       - career-clarity
       - identity-purpose
   - `ReflectionLabelAssignment`:
     - N-to-N link between reflections and labels

The combined view:

- `v_reflection_signals`:
  - includes both:
    - `category`
    - `labels_text` (comma-separated labels per reflection)

Key queries:

- `22_reflection_labels_overview.sql`
  - how many reflections use each label.
- `23_reflections_by_label.sql`
  - reflections for a given label.
- `24_reflection_label_matrix.sql`
  - cross between labels and sentiment labels.

This mirrors Azure AI Language classification,
but keeps PURE in control of its taxonomy.

---

## 5. PII detection

### Azure AI Language concept

- PII detection:
  - find sensitive information in text
  - optionally mask or remove it.

### PURE equivalent

- `ReflectionAnalysis.pii_flag`:
  - boolean flag:
    - 1 → PII present
    - 0 → no PII detected

Usage in PURE:

- control which reflections can be:
  - made PUBLIC
  - or exported to external tools
- guide future governance rules:
  - for example:
    - “do not index reflections with `pii_flag = 1` in a public search index”

PII redaction / masking is handled outside PURE,
in the same workflow that calls Azure AI Language.

---

## 6. Ingestion workflows

### Azure AI Language concept

- An application:
  - reads data from a source
  - calls Azure AI Language
  - persists results.

### PURE equivalent

Workflows are split between:

1. External application / notebook (outside this repo):

   - reads from `Reflection`
   - calls Azure AI Language (sentiment, key phrases, classification, PII)
   - writes a JSONL file following:

     - `docs/intelligence/azure-ai-language-ingestion.md`

2. PURE ingestion tool:

   - `tools/ingest_reflection_analysis.py`:
     - reads the JSONL file
     - writes to:
       - `ReflectionAnalysis`
       - `ReflectionLabel`
       - `ReflectionLabelAssignment`

This preserves:

- a clear boundary between:
  - cloud calls
  - and local, reproducible state
- the ability to:
  - re-run analysis
  - compare different runs
  - keep historical JSONL artifacts per date in:
    - `data/azure-ai-language/`

---

## 7. From Applied Skills to PURE: end-to-end view

In the Applied Skills path you:

1. Prepare text data.
2. Call Azure AI Language:
   - sentiment analysis
   - key phrase extraction
   - text classification
   - PII detection
3. Interpret results.
4. Integrate them into an application.

In PURE, the same flow becomes:

1. **Prepare text data**  
   - Write real reflections into `Reflection`.
   - Link them to:
     - study sessions
     - events
     - career engagements.

2. **Call Azure AI Language (outside PURE)**  
   - Use a notebook or app to:
     - query reflections
     - call Azure AI Language
     - produce a JSONL file with results.

3. **Ingest results into PURE**  
   - Use:
     - `tools/ingest_reflection_analysis.py`
   - to populate:
     - `ReflectionAnalysis`
     - `ReflectionLabel` + `ReflectionLabelAssignment`.

4. **Query and interpret**  
   - Use:
     - `v_reflection_signals`
     - queries 16–18 and 22–24
   - to:
     - inspect sentiment
     - see key phrases
     - understand categories and labels
     - correlate with events, studies and career.

This is how PURE turns the Applied Skills into
a governed, queryable and extensible system.