---
name: persona-craft
description: >
  Render a deliverable through a voice persona, shaped for an audience persona. Use for
  /jrit-persona:persona-craft, "write this as <persona>", "draft this for <audience>", or any request
  naming both a voice to write in and a reader to write for. Both personas are required
  arguments; a missing or unresolved one fails the run rather than guessing. v1 produces the
  deliverable directly as prose or markdown in the response; it never spawns an agent and never
  produces a branded or visual build (those stay with a build skill the user invokes separately).
user-invocable: true
---

# craft: render a deliverable through a voice, at an audience's altitude

Shared text comes from the `persona-reference` skill: load a topic by invoking that skill with the topic name, or, in a harness with no skill tool, read that skill's `SKILL.md` and the named file in its `references/` folder.

You take a voice persona (the writer) and an audience persona (the reader), and render one deliverable that sounds like the voice and lands at the audience's altitude.
Any persona may be the voice and any persona may be the audience, and the same persona may be both.
Two arguments are always required: which persona writes, and which persona reads.
If the user names only one, or names neither, ask for the missing name before doing anything else; do not default one of them.

## Step 0: resolve both personas

Resolve the voice persona name and the audience persona name independently, following the four-tier order in the `resolution` topic of the `persona-reference` skill: the project library, then the user library, then the team library when configured, then the distributed library, with the most local tier winning on a name collision.
State both resolved paths in your response before producing anything else, for example:

```
voice persona resolved: personas/architecture-reviewer.md (project)
audience persona resolved: personas/leadership-audience.md (project)
```

If either name resolves in no tier, stop and report the resolution failure exactly as the `resolution` topic of the `persona-reference` skill describes (the missing name and every searched location for that persona).
This is a hard fail, not a guess: never fall back to an unnamed default voice or a generic audience, and never proceed with only one persona resolved.

When a resolved persona's frontmatter carries a `kind:` or `seats:` line, stop and say the file uses a retired `kind:` or `seats:` line.
Give the one-line fix: delete the line (seats are derived from the persona's `## As <seat>` sections).

## Step 1: read the transformation matrix

Load the `voice-framework` topic of the `persona-reference` skill.
A craft deliverable is a "written deliverable" in the personality-by-artifact transformation matrix; take the voice persona's `Warmth` and `Formality` positions and use the matching cell (Warm+Casual, Warm+Formal, Clinical+Casual, or Clinical+Formal; treat `playful` as the `warm` column, since the matrix only names four cells) as the base register.
Layer the voice persona's `Opinionatedness` and `Emotional awareness` on top using the axis definitions earlier in the same reference: an opinionated voice states a preference and its reasoning rather than presenting options equally, and an emotionally-attentive voice may acknowledge context the material carries, while a task-focused voice reports it plainly.
Carry the voice persona's `Notes:` and `Cares about:` into what the deliverable emphasizes and how findings or recommendations are framed.
When the voice persona has a `## As creator` section, its `Emphasizes:` joins `Notes:` and `Cares about:` in what the deliverable foregrounds.
Its `Produces:` tells you the forms this voice is used to writing, which informs register but never overrides what the user asked for.

## Step 2: shape for the audience's altitude

The audience persona's `Stance` sets the reader's altitude, not the voice's.
When the audience persona has a `## As audience` section, its `Wants first:` decides lead order.
Summary-first opens with one summary paragraph, before any background, methodology, or detail follows.
Detail-first opens with detail and does not lead with a whole-document summary.
Without that section, lead order is read from the Stance: if it says the reader wants the executive summary, the ask, or the bottom line before supporting detail, the deliverable is summary-first, and if it says the reader wants detail, background, or reasoning before a conclusion, the deliverable is detail-first.
Match the audience's `Expertise` (skip or compress what the reader already knows) and its `Cares about` line (foreground the dimensions it names, such as cost, risk, or dates).
When a `## As audience` section is present, its `Cares about:` is foregrounded alongside the Stance's.

Read the `## Jargon` section of the `persona-format` topic of the `persona-reference` skill, and apply the audience's `jargon-tolerance` (`low`, `medium`, `high`) and `banned-jargon` exactly as defined there.
Every term on the `banned-jargon` list is absent from the deliverable, with no synonym substitution that still carries the same jargon meaning.
When the audience persona has no `jargon-tolerance`, no tolerance level is applied or inferred: only `banned-jargon` and plain clarity apply.
Creator jargon is never a persona field, so the writer's jargon always follows the audience.

## Step 3: write the deliverable

Produce the deliverable as your response: prose or markdown, sized to what was asked.
This is v1: it never spawns a subagent to write, and it never produces a branded or visual build (slides, one-pagers, styled HTML); those stay with a dedicated build skill the user invokes separately, and craft says so if asked for one.
Composition rule from the shared references still applies: the persona changes voice and altitude, never substance; do not drop a fact, hedge, or caveat the source material needs just because the voice or audience would prefer it omitted.

## What this skill is not

Not a fit check: it does not judge an existing artifact against a persona (that is `review`).
Not creation: it does not build a new persona file (that is `new`).
Not agent generation: it does not write a `.claude/agents/*.md` subagent (that is `spawn`).
