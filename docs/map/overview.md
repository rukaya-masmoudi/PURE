# PURE Map — v1

PURE is an architectural system that turns my professional growth into something measurable, navigable, and governed.

This map explains how to read the current version of PURE.

---

## Blocks and current status

PURE is structured into blocks.

They are in these states:

- Identity — active
- Growth — active (Studies + Calendar)
- Impact — active (Life)
- Intelligence — locked (future)
- System — active

Each block grows phase by phase.
Nothing appears “all at once”.

---

## Identity (active)

Identity is not a biography.

In PURE, Identity is:

- How my learning behaviour looks as data
- How my community participation looks as data
- How these two worlds coexist in a single system

Today, Identity is visible through:

- Studies metrics (consistency, focus, energy)
- Life events (where I show up, in which roles)
- The cross-layer calendar (days with study, events, or both)

See:

- db/queries/01–06 for Studies
- db/queries/07–10 for Life
- db/queries/11–12 for the calendar

---

## Growth (active: Studies + Calendar)

Growth is about evolution over time.

What exists today:

- Study sessions with duration, difficulty, energy, and status
- Derived daily metrics (view v_day_metrics)
- Weekly and monthly aggregations via queries
- Calendar view combining Studies and Life by date

Questions you can answer:

- On which days do I actually sit down to study?
- How many hours do I invest per week or month?
- Which topics receive most of my time?
- On which days do learning and events overlap?

All of this lives in SQLite and is reproducible.

---

## Impact (active: Life)

Impact is about presence in the tech ecosystem.

What exists today:

- Communities
- Cities and venues
- Events with date, language, and external URLs
- My roles:
  - attendee
  - speaker
  - community-collaborator
- Contributions when I actively speak
- One cover photo per event (metadata only)

Questions you can answer:

- Where do I go?
- In which communities am I present?
- What roles do I take in each event?
- Which events are important enough to have a cover photo?

---

## Intelligence (locked)

Intelligence will be the layer where AI is applied **on top of** PURE.

It will not be:

- “Random AI demos”
- “Disconnected notebooks”

It will be:

- NLP and search over my own trajectory
- RAG on curated, structured data
- Assistants that understand this system

This block is intentionally locked until:

- The data foundations are stable
- The Studies and Life blocks are coherent
- The roadmap of certifications reaches the right point

---

## System (active)

System is everything that makes PURE feel like a product, not a hobby.

What exists today:

- SQLite schema with catalogs, core entities, and views
- Reproducible local build:
  - python tools/build_db.py
- Minimal but real seed data:
  - Study sessions
  - Certifications
  - Events and participations
  - Media metadata for event covers
- Query packs for:
  - Studies
  - Life
  - Calendar

Next System steps will focus on:

- Keeping the schema coherent while it grows
- Adding new layers without breaking existing ones
- Preparing for future APIs, dashboards, and AI

---

## How to read PURE today

PURE is already:

- Structured
- Reproducible
- Honest about what exists and what does not (yet)

You can:

- Build the database once
- Run the curated queries
- See my growth and impact as data

Everything else (apps, dashboards, assistants) will be layered on top,
not instead of this foundation.