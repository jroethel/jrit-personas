---
name: craft
description: >
  Render a deliverable through a voice persona, shaped for an audience persona. Use for
  /jrit-persona:craft, "write this as <persona>", "draft this for <audience>", or any request
  naming both a voice to write in and a reader to write for. Both personas are required
  arguments; a missing or unresolved one fails the run rather than guessing. v1 produces the
  deliverable directly as prose or markdown in the response; it never spawns an agent and never
  produces a branded or visual build (those stay with a build skill the user invokes separately).
user-invocable: true
---

# craft: render a deliverable through a voice, at an audience's altitude

You take a voice persona (an `agent` kind: the writer) and an audience persona (an `audience` kind: the reader), and render one deliverable that sounds like the voice and lands at the audience's altitude.
Two arguments are always required: which persona writes, and which persona reads.
If the user names only one, or names neither, ask for the missing name before doing anything else; do not default one of them.

## Step 0: resolve both personas

Resolve the voice persona name and the audience persona name independently, following `${CLAUDE_PLUGIN_ROOT}/references/resolution.md`: the project's `personas/` directory first, then the global `~/.config/jrit/personas/` library, project wins on a name collision.
State both resolved paths in your response before producing anything else, for example:

```
voice persona resolved: personas/architecture-reviewer.md (project)
audience persona resolved: personas/leadership-audience.md (project)
```

If either name resolves in neither location, stop and report the resolution failure exactly as `references/resolution.md` describes (the missing name and both searched locations for that persona).
This is a hard fail, not a guess: never fall back to an unnamed default voice or a generic audience, and never proceed with only one persona resolved.

## Step 1: read the transformation matrix

Read `${CLAUDE_PLUGIN_ROOT}/references/voice-framework.md`.
A craft deliverable is a "written deliverable" in the personality-by-artifact transformation matrix; take the voice persona's `Warmth` and `Formality` positions and use the matching cell (Warm+Casual, Warm+Formal, Clinical+Casual, or Clinical+Formal; treat `playful` as the `warm` column, since the matrix only names four cells) as the base register.
Layer the voice persona's `Opinionatedness` and `Emotional awareness` on top using the axis definitions earlier in the same reference: an opinionated voice states a preference and its reasoning rather than presenting options equally, and an emotionally-attentive voice may acknowledge context the material carries, while a task-focused voice reports it plainly.
Carry the voice persona's `Notes:` and `Cares about:` into what the deliverable emphasizes and how findings or recommendations are framed.

## Step 2: shape for the audience's altitude

The audience persona's `Stance` sets the reader's altitude, not the voice's.
If the audience's Stance says it wants the executive summary, the ask, or the bottom line before supporting detail, the deliverable opens with that summary layer first, in one paragraph, before any background, methodology, or detail follows.
If the audience's Stance instead says it wants detail, background, or reasoning before a conclusion, the deliverable opens with that detail and does not lead with a whole-document summary.
Match the audience's `Expertise` (skip or compress what the reader already knows) and its `Cares about` line (foreground the dimensions it names, such as cost, risk, or dates).

Honor the audience persona's `jargon-tolerance` and, when present, its `banned-jargon` list: every term on that list is absent from the deliverable, with no synonym substitution that still carries the same jargon meaning.
An audience with no `banned-jargon` key has no banned terms to enforce beyond ordinary clarity.

## Step 3: write the deliverable

Produce the deliverable as your response: prose or markdown, sized to what was asked.
This is v1: it never spawns a subagent to write, and it never produces a branded or visual build (slides, one-pagers, styled HTML); those stay with a dedicated build skill the user invokes separately, and craft says so if asked for one.
Composition rule from the shared references still applies: the persona changes voice and altitude, never substance; do not drop a fact, hedge, or caveat the source material needs just because the voice or audience would prefer it omitted.

## What this skill is not

Not a fit check: it does not judge an existing artifact against a persona (that is `review`).
Not creation: it does not build a new persona file (that is `new`).
Not agent generation: it does not write a `.claude/agents/*.md` subagent (that is `spawn`).
