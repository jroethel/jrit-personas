---
max_turns: 10
allowed_tools: [Skill, Read, Write]
expected_outcome: |
  1. The `craft` skill resolves both personas from the project `personas/` directory and states both resolved paths.
  2. It refuses neither persona for the role it is named in: `leadership-audience` writes as the voice and `architecture-reviewer` reads as the audience.
  3. It writes the deliverable, a recommendation on the distributed cache, in the leadership-audience voice: warm, neutral, and formal.
  4. The deliverable foregrounds what the architecture-reviewer reader cares about: scalability, robustness, and maintainability.
---

Use the `/jrit-persona:craft` skill to write a short deliverable, roughly 200 to 400 words, recommending whether the team should add a distributed cache in front of the primary database.
Use `leadership-audience` as the voice persona and `architecture-reviewer` as the audience persona.
