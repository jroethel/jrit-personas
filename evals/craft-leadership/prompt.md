---
max_turns: 10
allowed_tools: [Skill, Read, Write]
expected_outcome: |
  1. The `craft` skill resolves both personas from the project `personas/` directory and states both resolved paths.
  2. The deliverable opens with an executive summary or recommendation before any supporting detail, matching the leadership-audience persona's stated preference.
  3. The deliverable contains none of the leadership-audience persona's banned terms: "synergy", "leverage", "circle back".
  4. The deliverable reads as opinionated and clinical, matching the architecture-reviewer voice, while still being a plain written recommendation rather than a review-style callout list.
---

Use the `/jrit-persona:craft` skill to write a short deliverable, roughly 200 to 400 words, recommending whether the team should add a distributed cache in front of the primary database.
Use `architecture-reviewer` as the voice persona and `leadership-audience` as the audience persona.
