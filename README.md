# jrit-persona

Portable personas for agents: written character sheets of stance (role, expertise, viewpoint) and voice that an agent can adopt or a skill can apply as a lens.
A persona is one file for one person, who may sit in any seat (`creator`, `reviewer`, `audience`) over one shared stance and voice.
A persona is data only, never permissions or tool instructions, and every persona carries provenance frontmatter so it stays portable across projects and models.

## Skills

- `/jrit-persona:persona-new` - create one persona in a single conversation: describe it free-form, confirm only the inferred and defaulted traits, and say which `## As <seat>` sections have anything to add.
- `/jrit-persona:persona-craft` - produce a deliverable from any two personas, one as the voice and one as the reader; the same persona may be both.
- `/jrit-persona:persona-review` - check an existing artifact in one of three modes: fit to a persona's voice, fit for a persona as its reader, or the persona's own approver read, run as a fresh-context lens.
- `/jrit-persona:persona-spawn` - generate a Claude Code subagent whose system prompt encodes any persona, stating the persona's provenance before it writes the file.

## Install

```bash
claude plugin marketplace add jroethel/jrit-personas
claude plugin install jrit-persona@jrit-persona
```

## Upgrading from 0.1

Version 0.2.0 is a breaking format change.
A skill that meets an old file stops and names the fix.
Seats are no longer declared: any persona may sit in any seat, and its optional `## As <seat>` sections add what that seat needs.
In each of your own persona files (project `personas/`, `~/.config/jrit/personas/` on every machine, and the team library), delete the `kind:` line and any `seats:` line.
No body edit is required.
This one command runs from any directory:

```bash
sed -i -e '/^kind: /d' -e '/^seats: /d' <file>
```

Then, from a checkout of this repo, `bash ci/check-persona-format.sh <file>` confirms the result.

Version 0.2.1 retires the `time-budget` key, which no skill read.
Delete any `time-budget:` line the same way: `sed -i '/^time-budget: /d' <file>`.

The full format is `skills/persona-reference/references/persona-format.md`.

## Attribution

The voice framework and the persona derivation method are adapted from [agenticnotetaking/arscontexta](https://github.com/agenticnotetaking/arscontexta), used under the MIT License.
See [NOTICE](NOTICE) for the full license notice.
