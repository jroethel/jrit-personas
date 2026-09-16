#!/usr/bin/env bash
# Seeds two different personas that share the name `reviewer`: one in the run's global
# library under the harness-provided HOME, one in the project personas/ directory, plus a
# short draft to review. The two Stance role lines are visibly different so the transcript
# shows which file was actually resolved. HOME is provided by the harness; never re-export it.
set -eu

mkdir -p "$HOME/.config/jrit/personas" personas

cat > "$HOME/.config/jrit/personas/reviewer.md" <<'GLOBAL'
---
name: reviewer
kind: audience
author: Dana Okafor
owner: Dana Okafor
created: 2026-09-15
last-validated: 2026-09-15
derivation-source: the external auditor reader profile in the compliance handbook
jargon-tolerance: low
---

## Stance

Role: an external compliance auditor reading a quarterly control report.
Expertise: audit standards and evidence requirements, with no familiarity with this system.
Viewpoint: every claim has to be traceable to dated evidence before it counts.
Cares about: dates, sign-offs, and an unbroken audit trail.

## Voice

Warmth: clinical
Opinionatedness: neutral
Formality: formal
Emotional awareness: task-focused
Notes: Full sentences, no abbreviations, and every claim attributed to a named source.
GLOBAL

cat > personas/reviewer.md <<'PROJECT'
---
name: reviewer
kind: audience
author: Dana Okafor
owner: Dana Okafor
created: 2026-09-15
last-validated: 2026-09-15
derivation-source: the project team's reader profile for night-shift status updates
jargon-tolerance: high
---

## Stance

Role: the on-call engineer who picks up the pager at the start of a night shift.
Expertise: runs this service day to day and knows its failure modes by name.
Viewpoint: the only thing that matters is what is broken right now and what to do next.
Cares about: current state, the exact next action, and who to page.

## Voice

Warmth: clinical
Opinionatedness: opinionated
Formality: casual
Emotional awareness: task-focused
Notes: Short lines, present tense, no preamble.
PROJECT

cat > status-update.md <<'DRAFT'
# Ingest pipeline status

The nightly ingest job has been failing intermittently since Tuesday.
Roughly one run in three times out partway through the transform stage.
The team has been looking at connection pool exhaustion as the likely cause.
A fix is in review and should land this week.
Until then the morning reports may be up to six hours stale.
DRAFT
