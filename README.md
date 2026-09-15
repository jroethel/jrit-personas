# jrit-persona

Portable personas for agents: written character sheets of stance (role, expertise, viewpoint) and voice that an agent can adopt or a skill can apply as a lens.
A persona is data only, never permissions or tool instructions, and every persona carries provenance frontmatter so it stays portable across projects and models.

## Skills

- `/jrit-persona:new` - create one persona in a single conversation: describe it free-form, then confirm only the inferred and defaulted traits.
- `/jrit-persona:craft` - produce a deliverable given one agent persona for voice and one audience persona for the reader.
- `/jrit-persona:review` - check an existing artifact against a persona and get concrete misalignment callouts, run as a fresh-context lens.
- `/jrit-persona:spawn` - generate a Claude Code subagent whose system prompt encodes a chosen agent persona.

## Install

```bash
claude plugin marketplace add jroethel/jrit-personas
claude plugin install jrit-persona@jrit-persona
```

## Attribution

The voice framework and the persona derivation method are adapted from [agenticnotetaking/arscontexta](https://github.com/agenticnotetaking/arscontexta), used under the MIT License.
See [NOTICE](NOTICE) for the full license notice.
