# Database

This folder contains the SQLite definition of PURE (current scope: Studies Layer).

## Structure

- schema.sql — tables, indexes, constraints, and views
- seed.sql — minimal public seed data
- queries/ — curated SQL queries to explore growth metrics
- pure.db — generated locally (ignored by git)

---

## Rebuild locally

From the repository root:

```bash
python tools/build_db.py
```

This recreates the database from scratch.

---

## Explore

After building the database, open pure.db with any SQLite client
and run the queries inside:

```bash
db/queries/
```

These queries allow you to explore:
- Daily metrics
- Weekly hours
- Monthly consistency
- Topic focus
- Tag distribution
- Cognitive load (difficulty vs energy)

---

This database is the foundation of PURE.

Before AI.
Before dashboards.
There is structure.