# Azure AI Search — Portfolio Index Design (Spec)

This document defines the **logical design** of the Azure AI Search index
that will be used for PURE.

It is a **spec only**:
- no Azure resources are created here
- no IaC is shipped in this repository

The goal is to have a clear, governed contract between:

- the relational world:
  - `v_portfolio_search_items`
- and the search world:
  - Azure AI Search index

---

## 1. Source dataset

The index uses as logical source:

- `v_portfolio_search_items`

which unifies:

- Study topics       (TOPIC)
- Events             (EVENT)
- Career engagements (ENGAGEMENT)
- Contributions      (CONTRIBUTION)
- Reflections        (REFLECTION)

Fields in the view:

- `item_type`
- `item_key`
- `main_date`
- `title`
- `kind_label`
- `secondary_label`
- `location`
- `tags_text`
- `sentiment_label`
- `category`

Note:
- The view only exposes **PUBLIC** items.
- PRIVATE data is filtered out at the SQL layer and never reaches search.

---

## 2. Index overview

### Index name (logical)

- `pure-portfolio-index`

This index represents:
- "Everything about my public professional and community activity
  that should be discoverable via search."

---

## 3. Field design

The mapping below uses Azure AI Search field types and capabilities.

For text fields, the default analyzer can be:

- `es.microsoft` for Spanish-dominant content
- or a standard analyzer for mixed-language scenarios

For Signal Intelligence v1, we keep it simple and assume a single analyzer.

### 3.1 Field table

| Field name       | Type                     | From                                                           | Key | Searchable | Filterable | Facetable | Sortable | Notes                                                |
|------------------|--------------------------|----------------------------------------------------------------|:---:|:----------:|:----------:|:---------:|:--------:|:-------------------------------------------------------------------|
| `id`             | `Edm.String`             | synthetic: `item_type + '-' + item_key`                        | ✅  | ❌        | ✅         | ❌       | ✅       | Primary key for the index                                                   |
| `itemType`       | `Edm.String`             | `item_type`                                                    | ❌  | ❌        | ✅         | ✅       | ✅       | TOPIC / EVENT / ENGAGEMENT / CONTRIBUTION / REFLECTION                      |
| `itemKey`        | `Edm.Int32`              | `item_key`                                                     | ❌  | ❌        | ✅         | ❌       | ✅       | Original numeric id from the source table                           |
| `mainDate`       | `Edm.DateTimeOffset`     | `main_date`                                                    | ❌  | ❌        | ✅         | ✅       | ✅       | Used for timeline and sorting                                            |
| `title`          | `Edm.String`             | `title`                                                        | ❌  | ✅        | ❌         | ❌       | ✅       | Main searchable text                                                     |
| `kindLabel`      | `Edm.String`             | `kind_label`                                                   | ❌  | ✅        | ✅         | ✅       | ✅       | e.g. Study topic, Event, education, work, volunteering, talk, panel, ... |
| `secondaryLabel` | `Edm.String`             | `secondary_label`                                              | ❌  | ✅        | ✅         | ✅       | ✅       | e.g. community name, organization name, event title                      |
| `location`       | `Edm.String`             | `location`                                                     | ❌  | ✅        | ✅         | ✅       | ✅       | City name (Madrid, Barcelona, ...)                                       |
| `tags`           | `Collection(Edm.String)` | split from `tags_text`                                         | ❌  | ✅        | ✅         | ✅       | ❌       | e.g. Azure, SQL, Python, Deep Learning                                   |
| `sentimentLabel` | `Edm.String`             | `sentiment_label`                                              | ❌  | ❌        | ✅         | ✅       | ❌       | Overall sentiment of the reflection (if itemType = REFLECTION)              |
| `category`       | `Edm.String`             | `category`                                                     | ❌  | ❌        | ✅         | ✅       | ❌       | High-level category (learning, community, career, ...)              |
| `hasSignals`     | `Edm.Boolean`            | derived (itemType = REFLECTION and sentiment/category present) | ❌  | ❌        | ✅         | ✅       | ❌       | Whether the item carries NLP signals                                        |
| `labels`         | `Collection(Edm.String)` | from reflection labels (if available)                          | ❌  | ✅        | ✅         | ✅       | ❌       | learning-win, community-pride, career-clarity, ...                  |

Notes:

- Only `id` is the key.
- All text searchable fields (`title`, `kindLabel`, `secondaryLabel`, `location`, `tags`, `labels`) share the same analyzer.
- `hasSignals` will be `true` primarily for REFLECTION items but the design allows future extension.

---

## 4. Field mapping from `v_portfolio_search_items`

### 4.1 Synthetic id

- `id` = `item_type || '-' || CAST(item_key AS TEXT)`

The exact concatenation is done in the ingestion layer
(not in the SQL view, to keep the relational model clean).

### 4.2 Direct mappings

- `itemType`       ← `item_type`
- `itemKey`        ← `item_key`
- `mainDate`       ← `main_date`
- `title`          ← `title`
- `kindLabel`      ← `kind_label`
- `secondaryLabel` ← `secondary_label`
- `location`       ← `location`
- `sentimentLabel` ← `sentiment_label`
- `category`       ← `category`

### 4.3 Tags

- `tags_text` in the view contains a comma-separated list of tags.
- The ingestion layer will:

  - split on `,`
  - trim whitespace
  - drop empty values

to populate:

- `tags : Collection(Edm.String)`

### 4.4 Labels and hasSignals

For items with `item_type = 'REFLECTION'`:

- The ingestion layer may query:

  - `v_reflection_signals`
  - or directly:
    - `ReflectionLabel` / `ReflectionLabelAssignment`

to populate:

- `labels` as a collection of strings
- `hasSignals = true` when:
  - a sentiment or category exists

For non-reflection items:

- `labels = []`
- `hasSignals = false`

---

## 5. Example index schema (JSON)

This JSON represents the **logical** index definition.

It is not shipped as IaC, but documents the intended configuration.

```json
{
  "name": "pure-portfolio-index",
  "fields": [
    {
      "name": "id",
      "type": "Edm.String",
      "key": true,
      "searchable": false,
      "filterable": true,
      "facetable": false,
      "sortable": true,
      "retrievable": true
    },
    {
      "name": "itemType",
      "type": "Edm.String",
      "searchable": false,
      "filterable": true,
      "facetable": true,
      "sortable": true,
      "retrievable": true
    },
    {
      "name": "itemKey",
      "type": "Edm.Int32",
      "searchable": false,
      "filterable": true,
      "facetable": false,
      "sortable": true,
      "retrievable": true
    },
    {
      "name": "mainDate",
      "type": "Edm.DateTimeOffset",
      "searchable": false,
      "filterable": true,
      "facetable": true,
      "sortable": true,
      "retrievable": true
    },
    {
      "name": "title",
      "type": "Edm.String",
      "searchable": true,
      "filterable": false,
      "facetable": false,
      "sortable": true,
      "retrievable": true,
      "analyzer": "es.microsoft"
    },
    {
      "name": "kindLabel",
      "type": "Edm.String",
      "searchable": true,
      "filterable": true,
      "facetable": true,
      "sortable": true,
      "retrievable": true,
      "analyzer": "es.microsoft"
    },
    {
      "name": "secondaryLabel",
      "type": "Edm.String",
      "searchable": true,
      "filterable": true,
      "facetable": true,
      "sortable": true,
      "retrievable": true,
      "analyzer": "es.microsoft"
    },
    {
      "name": "location",
      "type": "Edm.String",
      "searchable": true,
      "filterable": true,
      "facetable": true,
      "sortable": true,
      "retrievable": true,
      "analyzer": "es.microsoft"
    },
    {
      "name": "tags",
      "type": "Collection(Edm.String)",
      "searchable": true,
      "filterable": true,
      "facetable": true,
      "sortable": false,
      "retrievable": true,
      "analyzer": "es.microsoft"
    },
    {
      "name": "sentimentLabel",
      "type": "Edm.String",
      "searchable": false,
      "filterable": true,
      "facetable": true,
      "sortable": false,
      "retrievable": true
    },
    {
      "name": "category",
      "type": "Edm.String",
      "searchable": false,
      "filterable": true,
      "facetable": true,
      "sortable": false,
      "retrievable": true
    },
    {
      "name": "hasSignals",
      "type": "Edm.Boolean",
      "searchable": false,
      "filterable": true,
      "facetable": true,
      "sortable": false,
      "retrievable": true
    },
    {
      "name": "labels",
      "type": "Collection(Edm.String)",
      "searchable": true,
      "filterable": true,
      "facetable": true,
      "sortable": false,
      "retrievable": true,
      "analyzer": "es.microsoft"
    }
  ]
}
```

## 6. Query patterns (conceptual)

Based on this design, common query patterns are:
1.	“Show everything Rukaya has done in Azure events in Madrid”
  - search = “Azure”
  - filter on:
  - itemType in ('EVENT', 'CONTRIBUTION')
  - location == 'Madrid'
2.	“Find all learning wins”
  - filter on:
  - labels/any(l: l eq 'learning-win')
3.	“Show my public work-related items in the last year”
  - filter on:
  - itemType in ('ENGAGEMENT', 'CONTRIBUTION')
  - mainDate ge <one year ago>
4.	“Show reflections about community with mixed or negative sentiment”
  - filter on:
    - itemType eq 'REFLECTION'
    - category eq 'community'
    - sentimentLabel in ('mixed', 'negative')

These patterns will later be implemented at the application layer,
but the index design already supports them.

---

## 7. Governance and scope
- Only PUBLIC items are indexed.
- The SQL view v_portfolio_search_items already enforces visibility.
- PII-sensitive reflections (with pii_flag = 1) can be excluded at:
- ingestion time (external workflow), or
- SQL view level in a future iteration.

Out of scope for this spec:
- data source and indexer configuration
- semantic ranker settings
- vector fields and embeddings
- any real Azure resource configuration

Those belong to later phases of PURE (Search, RAG, Assistants).