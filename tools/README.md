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