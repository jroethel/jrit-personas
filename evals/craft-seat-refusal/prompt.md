---
max_turns: 6
allowed_tools: [Skill, Read, Write]
expected_outcome: |
  1. The `craft` skill resolves both personas from the project `personas/` directory and states both resolved paths.
  2. It stops before writing any deliverable, because the roles are swapped: the voice persona `leadership-audience` holds only the `audience` seat, and the audience persona `architecture-reviewer` holds only the `creator` seat.
  3. The stop message names each persona and the seat it is missing: `leadership-audience` lacks `creator`, and `architecture-reviewer` lacks `audience`.
  4. No deliverable text is produced and no file is written; the skill does not fall back to a default voice or reader.
---

Use the `/jrit-persona:craft` skill to write a short deliverable recommending whether the team should add a distributed cache in front of the primary database.
Use `leadership-audience` as the voice persona and `architecture-reviewer` as the audience persona.
