# jrit-persona

Portable personas for agents: written character sheets of stance (role, expertise, viewpoint) and voice that an agent can adopt or a skill can apply as a lens.
A persona is one file for one person, holding one or more seats (`creator`, `reviewer`, `audience`) over one shared stance and voice.
A persona is data only, never permissions or tool instructions, and every persona carries provenance frontmatter so it stays portable across projects and models.

## Skills

- `/jrit-persona:new` - create one persona in a single conversation: describe it free-form, confirm only the inferred and defaulted traits, and say which seats apply.
- `/jrit-persona:craft` - produce a deliverable given one persona holding `creator` for the voice and one holding `audience` for the reader.
- `/jrit-persona:review` - check an existing artifact for fit to a creator voice, for fit for an audience, or review it as an approver from the reviewer seat, run as a fresh-context lens.
- `/jrit-persona:spawn` - generate a Claude Code subagent whose system prompt encodes a chosen persona holding `creator`.

## Install

```bash
claude plugin marketplace add jroethel/jrit-personas
claude plugin install jrit-persona@jrit-persona
```

## Upgrading from 0.1

Version 0.2.0 is a breaking format change.
A skill that meets an old file stops and names the fix.
In each of your own persona files (project `personas/`, `~/.config/jrit/personas/` on every machine, and the team library), `kind: agent` becomes `seats: [creator]` and `kind: audience` becomes `seats: [audience]`.
No body edit is required.
This one command runs from any directory:

```bash
sed -i -e 's/^kind: agent$/seats: [creator]/' -e 's/^kind: audience$/seats: [audience]/' <file>
```

Then, from a checkout of this repo, `bash ci/check-persona-format.sh <file>` confirms the result.
The full format is `docs/persona-format.md`.

## Attribution

The voice framework and the persona derivation method are adapted from [agenticnotetaking/arscontexta](https://github.com/agenticnotetaking/arscontexta), used under the MIT License.
See [NOTICE](NOTICE) for the full license notice.
