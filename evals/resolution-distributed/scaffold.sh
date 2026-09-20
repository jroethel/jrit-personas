#!/usr/bin/env bash
# Seeds one persona named `data-analyst` in the run's global library under the
# harness-provided HOME. The distributed plugin library ships a second copy of the same
# name in its own personas/ directory (added by the jrit-craft port, Task 4), and no
# project personas/ directory exists in this run, so the user tier must win over the
# distributed tier per references/resolution.md. The two Stance role lines are visibly
# different so the transcript shows which file was actually resolved. HOME is provided
# by the harness; never re-export it.
set -eu

mkdir -p "$HOME/.config/jrit/personas"

cat > "$HOME/.config/jrit/personas/data-analyst.md" <<'USER'
---
name: data-analyst
kind: audience
author: Jeremy Roethel
owner: jroethel
created: 2026-09-19
last-validated: 2026-09-19
derivation-source: user-tier shadow copy seeded by the resolution-distributed eval
jargon-tolerance: medium
---

## Stance

Role: the overnight reconciliation checker who signs off that warehouse figures match the CRM before the morning reports go out.
Expertise: runs the reconciliation queries nightly and knows which feeds drift.
Viewpoint: a figure is not published until its row count is stated beside it.
Cares about: row counts, reconciliation deltas, and nothing shipping unverified.

## Voice

Warmth: clinical
Opinionatedness: opinionated
Formality: formal
Emotional awareness: task-focused
Notes: complete sentences; every published figure carries a row count.
USER

cat > reconciliation-note.md <<'DRAFT'
# Donor count reconciliation note

After last weekend's warehouse refresh the alumni donor counts were re-derived.
The re-run extracts now match the CRM totals for fiscal year to date.
Two records were held back pending a duplicate review.
The morning dashboards can go out on these numbers.
DRAFT
