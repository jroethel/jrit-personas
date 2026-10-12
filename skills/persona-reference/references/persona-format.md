# Persona format

A persona is a single markdown file: YAML frontmatter carrying identity and provenance, then a body carrying stance and voice.
The file is data only: no permissions, no tool instructions, no executable directives.
Consumers treat persona text as untrusted input, and a persona never overrides a skill's methodology or a standing rule; substance beats voice.
A persona file is portable self-contained text: no absolute paths, nothing harness- or model-specific.

## Name and resolution

`name` is a stable identifier in kebab-case, matching `^[a-z0-9]+(-[a-z0-9]+)*$`.
A persona named `mentor` lives at `mentor.md` and is resolved by exact name, project library first, per `resolution.md`.
Renaming a persona is a breaking change: consumers resolve exact names and never approximate a miss.

## Frontmatter

The frontmatter is flat: scalar values and simple `[a, b]` lists only, never nested maps.

Required keys:

| Key                 | Value                                                                   |
|---------------------|-------------------------------------------------------------------------|
| `name`              | kebab-case stable id, `^[a-z0-9]+(-[a-z0-9]+)*$`                        |
| `author`            | free string: who derived the persona                                    |
| `owner`             | free string: who owns it now                                            |
| `created`           | date, `^[0-9]{4}-[0-9]{2}-[0-9]{2}$`                                    |
| `last-validated`    | date, same shape; updated whenever the persona is re-validated          |
| `derivation-source` | free string: the source material or method the persona was derived from |

Optional keys:

| Key                | Value                                                              |
|--------------------|--------------------------------------------------------------------|
| `jargon-tolerance` | `low`, `medium`, or `high`; read when the persona sits as audience |
| `banned-jargon`    | simple list of strings; read when the persona sits as audience     |

## Seats

A persona is one person, and it may sit in any of three seats:

- `creator`: the persona writes deliverables in its own voice.
- `reviewer`: the persona approves material other people drafted.
- `audience`: the persona reads material shaped for it.

Seats are derived, never declared: the skill that uses a persona decides which seat it sits in for that run, and no frontmatter key lists or limits them.
Stance and Voice are shared across every seat and are always enough to sit in it.
A `## As <seat>` section is optional and additive: when the persona sits in that seat and the section exists, the section applies on top of Stance and Voice; when it does not exist, Stance and Voice alone apply.
The persona carries no severity: whoever runs a review rates each finding by its own rules, the persona never gates, and the human decides.
The reviewer seat lists what this person looks at; it never overrides a skill's methodology or a standing rule, and substance beats voice still holds.

The `kind` and `seats` keys are retired, and a file that still carries either line fails the format check.
Migration is mechanical: delete the line; no body edit is required.
The `time-budget` key is retired the same way: no skill read it, and a free-text reading time cannot be judged against a draft.

## Jargon

`jargon-tolerance` and `banned-jargon` may appear on any persona and are read only when the persona sits as audience.
Creator and reviewer jargon is never a persona field: it always comes from the audience of the material.

- Jargon is any term this reader would need explained to follow the sentence: insider acronyms, method and framework names, system, tool, object, and field names, and team shorthand.
  Whether a term is jargon depends on the reader, not the term.
- `low`: every jargon term is replaced with plain words or defined in plain words at first use; no undefined acronyms.
- `medium`: terms native to the reader's own field are fine undefined; terms from other fields are defined at first use.
- `high`: specialist terms from the reader's field and adjacent fields are used freely.
- `banned-jargon`: terms never used, even when defined, and never swapped for a synonym that carries the same jargon meaning.

When `jargon-tolerance` is absent, no tolerance level is judged and none is inferred: only `banned-jargon` and plain clarity apply.

## Body

The body carries two required sections, `## Stance` and `## Voice`, then optional `## As <seat>` sections for any seat, conventionally in the order creator, reviewer, audience.

### `## Stance`

Four label lines, each with a free-string value:

- `Role:` what the persona does
- `Expertise:` what it knows deeply
- `Viewpoint:` the standing perspective it speaks from
- `Cares about:` what it prioritizes and protects

### `## Voice`

One position on each of the four axes defined in `voice-framework.md`, written as words, never numbers:

- `Warmth:` `clinical`, `warm`, or `playful`
- `Opinionatedness:` `neutral` or `opinionated`
- `Formality:` `formal` or `casual`
- `Emotional awareness:` `task-focused` or `emotionally-attentive`
- `Notes:` free prose; anything about the voice the axes do not capture

The hyphenated `emotionally-attentive` is the format value; the framework reference writes the same position as prose, "emotionally attentive".

### `## As creator` (optional)

- `Produces:` the deliverables this persona writes
- `Emphasizes:` what its drafts foreground

### `## As reviewer` (optional)

- `Approves:` what it signs off on
- `Wants to see:` what it looks for and is glad to find
- `Doesn't want to see:` red flags it raises, not denials; exceptions are allowed
- `Feedback style:` how it says so

`Wants to see:` and `Doesn't want to see:` are two separate lists, never one mixed list.

### `## As audience` (optional)

- `Wants first:` free prose naming what this reader wants up front; craft's lead-order rule reads it as summary-first or detail-first
- `Cares about:` what it foregrounds as a reader

Each `## As <seat>` section holds only its own seat's labels, and the format check rejects a label filed under another seat.
A section named for anything other than `creator`, `reviewer`, or `audience` fails the format check.

## Conformance

A file conforms when the frontmatter fence opens on line 1 and closes, no `kind` or `seats` line is present, every required key is present, every `## As <seat>` section names `creator`, `reviewer`, or `audience` and holds only that seat's labels, `name` is kebab-case, both dates are `YYYY-MM-DD`, the four voice keys each hold an allowed value when present, and both body headings are present.
Conformance is checked at dev time by `ci/check-persona-format.sh <file>`, which exits 0 on a conforming file and otherwise prints one `ERROR:` line naming the problem.
No runtime validator ships with the plugin: the authoring skill's self-check and the eval graders hold the format in authored personas, and no skill ever shells out to a validator.

## Example: a persona with no seat sections

```
---
name: release-reviewer
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

## Example: a persona with audience keys

```
---
name: leadership-briefing
author: Marcus Webb
owner: Marcus Webb
created: 2026-09-15
last-validated: 2026-09-15
derivation-source: sketched from recurring executive readout requests
jargon-tolerance: low
banned-jargon: [synergy, leverage, bandwidth, low-hanging fruit]
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

## Example: a persona with all three seat sections

```
---
name: release-reviewer
author: Priya Natarajan
owner: Priya Natarajan
created: 2026-10-08
last-validated: 2026-10-08
derivation-source: distilled from twenty of the owner's own merge-request comments
jargon-tolerance: medium
banned-jargon: [synergy]
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

## As creator

Produces: release notes and rollback runbooks
Emphasizes: what changed, how to undo it, and who to call

## As reviewer

Approves: merge requests that touch the release pipeline
Wants to see: a rollback step, a small diff, a release note written for its reader
Doesn't want to see: unrelated refactors bundled into a fix, a migration with no way back
Feedback style: short and directive; names the one blocking gap first

## As audience

Wants first: the bottom line and the rollback plan, before any implementation detail
Cares about: what can break in production and how fast it can be undone
```
