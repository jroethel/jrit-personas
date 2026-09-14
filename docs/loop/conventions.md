# Loop conventions

This file is the prose surface for the loop convention in this repo.
Machine-readable keys live in the sibling `docs/loop/pointer.md`.

## The `agent:` label vocabulary

Exactly one of these is active on an issue at a time:

- `agent:todo` - open and unclaimed.
- `agent:working` - claimed and in progress.
- `agent:needs-input` - blocked on a human answer.
- `agent:review` - work done, awaiting review.
- `agent:done` - reachable only through the receipt helper's `done` verb, never applied by hand.

Two additional labels sit outside that rotation:

- `idea` - a parked backlog item, not active work.
- `wayfinder:map` - a wayfinder mapping item.

## Filename grammar

- Handoffs: `docs/handoffs/<unit-slug>-<session-date>.md`, one file per unit per session.
- Briefs: `docs/briefs/<brief-slug>.md`, one file per brief.
- Plans: `docs/plans/<plan-slug>.md`, one file per plan.
- Reviews: `docs/reviews/<review-slug>-<date>.md`, one file per review run.

## Archive and graduation rules

Work that is finished and no longer active moves to `docs/archive/`.
A handoff, brief, plan, or review graduates to the archive once its issue reaches `agent:done`; nothing is deleted, everything moves.

## Verbose-announce convention

When a loop skill claims, advances, or closes an issue, it announces the action in full (issue number, label transition, and the receipt line) rather than summarizing it - the tracker's UI is the durable record, so the announcement in-session must match it exactly.
