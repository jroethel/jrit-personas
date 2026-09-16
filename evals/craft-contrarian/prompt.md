---
max_turns: 10
allowed_tools: [Skill, Read, Write]
expected_outcome: |
  1. The `craft` skill resolves both personas from the project `personas/` directory and states both resolved paths.
  2. The deliverable opens with detail, background, or reasoning rather than an executive summary, matching the detail-first-audience persona's stated preference.
  3. The deliverable does not lead with a whole-document summary the way the leadership-audience render would.
  4. The deliverable still reads as opinionated and clinical, matching the architecture-reviewer voice.
---

Use the `/jrit-persona:craft` skill to write a short deliverable, roughly 200 to 400 words, recommending whether the team should add a distributed cache in front of the primary database.
This is the same deliverable topic used elsewhere in this suite, rendered under a different audience.
Use `architecture-reviewer` as the voice persona and `detail-first-audience` as the audience persona.
