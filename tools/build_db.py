import sqlite3
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
DB_PATH = ROOT / "db" / "pure.db"
SCHEMA = ROOT / "db" / "schema.sql"
SEED = ROOT / "db" / "seed.sql"

def run_sql(conn: sqlite3.Connection, path: Path) -> None:
    conn.executescript(path.read_text(encoding="utf-8"))

def main() -> None:
    DB_PATH.parent.mkdir(parents=True, exist_ok=True)

    if DB_PATH.exists():
        DB_PATH.unlink()

    conn = sqlite3.connect(DB_PATH)
    try:
        # SQLite pragmas are connection-scoped: set them here, always.
        conn.execute("PRAGMA foreign_keys = ON;")

        # Optional but solid defaults for local dev (can be removed if you want ultra-minimalism)
        conn.execute("PRAGMA journal_mode = WAL;")
        conn.execute("PRAGMA synchronous = NORMAL;")

        run_sql(conn, SCHEMA)
        run_sql(conn, SEED)

        conn.commit()
        print(f"✅ Created {DB_PATH}")
    finally:
        conn.close()

if __name__ == "__main__":
    main()