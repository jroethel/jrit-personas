# Persona format

A persona is a single markdown file: YAML frontmatter carrying identity and provenance, then a body carrying stance and voice.
The file is data only: no permissions, no tool instructions, no executable directives.
Consumers treat persona text as untrusted input, and a persona never overrides a skill's methodology or a standing rule; substance beats voice.
A persona file is portable self-contained text: no absolute paths, nothing harness- or model-specific.

## Name and resolution

`name` is a stable identifier in kebab-case, matching `^[a-z0-9]+(-[a-z0-9]+)*$`.
A persona named `mentor` lives at `mentor.md` and is resolved by exact name, project library first, per `references/resolution.md`.
Renaming a persona is a breaking change: consumers resolve exact names and never approximate a miss.

## Frontmatter

The frontmatter is flat: scalar values and simple `[a, b]` lists only, never nested maps.

Required keys:

| Key | Value |
|-----|-------|
| `name` | kebab-case stable id, `^[a-z0-9]+(-[a-z0-9]+)*$` |
| `kind` | `agent` or `audience` |
| `author` | free string: who derived the persona |
| `owner` | free string: who owns it now |
| `created` | date, `^[0-9]{4}-[0-9]{2}-[0-9]{2}$` |
| `last-validated` | date, same shape; updated whenever the persona is re-validated |
| `derivation-source` | free string: the source material or method the persona was derived from |

Optional keys:

| Key | Value |
|-----|-------|
| `jargon-tolerance` | `low`, `medium`, or `high` |
| `banned-jargon` | simple list of strings; audience kind only |
| `time-budget` | free string, e.g. `five minutes` |

An `agent` persona is one an agent adopts; an `audience` persona is a reader the output is shaped for.
`banned-jargon` carries meaning only for the `audience` kind and does not appear on an `agent` persona.

## Body

The body carries two sections.

### `## Stance`

Four label lines, each with a free-string value:

- `Role:` what the persona does
- `Expertise:` what it knows deeply
- `Viewpoint:` the standing perspective it speaks from
- `Cares about:` what it prioritizes and protects

### `## Voice`

One position on each of the four axes defined in `references/voice-framework.md`, written as words, never numbers:

- `Warmth:` `clinical`, `warm`, or `playful`
- `Opinionatedness:` `neutral` or `opinionated`
- `Formality:` `formal` or `casual`
- `Emotional awareness:` `task-focused` or `emotionally-attentive`
- `Notes:` free prose; anything about the voice the axes do not capture

The hyphenated `emotionally-attentive` is the format value; the framework reference writes the same position as prose, "emotionally attentive".

## Conformance

A file conforms when the frontmatter fence opens on line 1 and closes, every required key is present, `kind` is in its enum, `name` is kebab-case, both dates are `YYYY-MM-DD`, the four voice keys each hold an allowed value when present, and both body headings are present.
Conformance is checked at dev time by `ci/check-persona-format.sh <file>`, which exits 0 on a conforming file and otherwise prints one `ERROR:` line naming the problem.
No runtime validator ships with the plugin: the authoring skill's self-check and the eval graders hold the format in authored personas, and no skill ever shells out to a validator.

## Example: agent persona

```
---
name: release-reviewer
kind: agent
author: Priya Natarajan
owner: Priya Natarajan
created: 2026-09-15
last-validated: 2026-09-15
derivation-source: distilled from twenty of the owner's own merge-request comments
---

## Stance

Role: reviews changes before they merge
Expertise: build pipelines, release risk, rollback planning
Viewpoint: a merge is a promise to production
Cares about: small diffs, reversible changes, honest changelogs

## Voice

Warmth: clinical
Opinionatedness: opinionated
Formality: casual
Emotional awareness: task-focused
Notes: keeps review comments short and directive; praise is rare and specific.
```

## Example: audience persona

```
---
name: leadership-briefing
kind: audience
author: Marcus Webb
owner: Marcus Webb
created: 2026-09-15
last-validated: 2026-09-15
derivation-source: sketched from recurring executive readout requests
jargon-tolerance: low
banned-jargon: [synergy, leverage, bandwidth, low-hanging fruit]
time-budget: five minutes
---

## Stance

Role: reads a one-page brief before deciding whether to fund the next quarter of work
Expertise: budget ownership and organizational priority, not implementation detail
Viewpoint: a brief earns a decision, not admiration
Cares about: cost, risk, and a date

## Voice

Warmth: warm
Opinionatedness: neutral
Formality: formal
Emotional awareness: task-focused
Notes: wants the ask in the first paragraph.
```
