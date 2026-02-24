import json
import sqlite3
import sys
from pathlib import Path
from typing import Any, Dict, List, Optional

ROOT = Path(__file__).resolve().parents[1]
DB_PATH = ROOT / "db/pure.db"


def get_visibility_id(conn: sqlite3.Connection, name: str) -> int:
    cur = conn.execute(
        "SELECT visibility_id FROM Visibility WHERE name = ?",
        (name.upper(),),
    )
    row = cur.fetchone()
    if row is None:
        raise ValueError(f"Visibility '{name}' not found in Visibility catalog")
    return row[0]


def upsert_reflection_analysis(conn: sqlite3.Connection, record: Dict[str, Any]) -> None:
    reflection_id = record["reflection_id"]

    sentiment = record.get("sentiment", {}) or {}
    sentiment_label = sentiment.get("label")
    sentiment_positive = sentiment.get("positive")
    sentiment_neutral = sentiment.get("neutral")
    sentiment_negative = sentiment.get("negative")

    key_phrases_list: List[str] = record.get("key_phrases") or []
    key_phrases = ", ".join(key_phrases_list) if key_phrases_list else None

    category: Optional[str] = record.get("category")
    provider: str = record.get("provider", "azure-ai-language")
    language_code: Optional[str] = record.get("language_code")
    pii_flag: int = 1 if record.get("pii_flag") else 0

    visibility_name = record.get("visibility", "PUBLIC")
    visibility_id = get_visibility_id(conn, visibility_name)

    labels: List[str] = record.get("labels") or []

    cur = conn.cursor()

    # Remove existing analysis and label assignments for this reflection (idempotent)
    cur.execute("DELETE FROM ReflectionAnalysis WHERE reflection_id = ?", (reflection_id,))
    cur.execute("DELETE FROM ReflectionLabelAssignment WHERE reflection_id = ?", (reflection_id,))

    # Insert new ReflectionAnalysis row
    cur.execute(
        """
        INSERT INTO ReflectionAnalysis (
          reflection_id,
          provider,
          language_code,
          sentiment_label,
          sentiment_positive,
          sentiment_neutral,
          sentiment_negative,
          key_phrases,
          category,
          pii_flag,
          visibility_id,
          created_at
        )
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, datetime('now'))
        """,
        (
            reflection_id,
            provider,
            language_code,
            sentiment_label,
            sentiment_positive,
            sentiment_neutral,
            sentiment_negative,
            key_phrases,
            category,
            pii_flag,
            visibility_id,
        ),
    )

    # Ensure labels exist and assign them
    for label_name in labels:
        normalized = label_name.strip()
        if not normalized:
            continue

        cur.execute(
            "INSERT OR IGNORE INTO ReflectionLabel (name) VALUES (?)",
            (normalized,),
        )
        cur.execute(
            "SELECT label_id FROM ReflectionLabel WHERE name = ?",
            (normalized,),
        )
        row = cur.fetchone()
        if row is None:
            raise RuntimeError(f"Failed to retrieve label_id for label '{normalized}'")
        label_id = row[0]

        cur.execute(
            """
            INSERT OR IGNORE INTO ReflectionLabelAssignment (reflection_id, label_id)
            VALUES (?, ?)
            """,
            (reflection_id, label_id),
        )


def load_jsonl(path: Path) -> List[Dict[str, Any]]:
    records: List[Dict[str, Any]] = []
    with path.open("r", encoding="utf-8") as f:
        for line in f:
            line = line.strip()
            if not line:
                continue
            records.append(json.loads(line))
    return records


def main() -> None:
    if len(sys.argv) != 2:
        print("Usage: python tools/ingest_reflection_analysis.py <path_to_jsonl>", file=sys.stderr)
        sys.exit(1)

    input_path = Path(sys.argv[1]).resolve()
    if not input_path.exists():
        print(f"Input file not found: {input_path}", file=sys.stderr)
        sys.exit(1)

    records = load_jsonl(input_path)
    if not records:
        print("No records found in input file.", file=sys.stderr)
        sys.exit(0)

    conn = sqlite3.connect(DB_PATH)
    try:
        conn.execute("PRAGMA foreign_keys = ON;")
        for record in records:
            upsert_reflection_analysis(conn, record)
        conn.commit()
        print(f"✅ Ingested {len(records)} reflection analysis record(s) into {DB_PATH.name}")
    finally:
        conn.close()


if __name__ == "__main__":
    main()