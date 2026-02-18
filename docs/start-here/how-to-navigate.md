# How to navigate PURE (2 minutes)

PURE is not a portfolio repository.

It is a reproducible system that models my professional growth as structured data.

Before AI.
Before dashboards.
Before assistants.

There is data.

---

## What exists today (v0.2.x)

- Studies Layer (SQLite)
- Public vs Private visibility model
- Real study sessions
- Derived daily metrics
- Rebuildable database (one command)

This is the foundation.

---

## What you can explore

You can explore:

- How consistent I am
- How many hours I invest per week
- Which topics I focus on
- My cognitive load (difficulty vs energy)

All of this is queryable.

Nothing is decorative.

---

## What is intentionally NOT here yet

- AI agents
- RAG
- Search assistants
- APIs
- Dashboards
- Community / Events / Projects layers

PURE grows phase by phase.

---

## Quick start

From the repository root:

```bash
python tools/build_db.py
```

Then open db/pure.db with any SQLite client
and run the queries inside:

db/queries/