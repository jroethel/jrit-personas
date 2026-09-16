---
max_turns: 10
allowed_tools: [Skill, Read]
expected_outcome: |
  1. No persona named `night-shift-oncall` exists in either location: the global library in this run's HOME is empty and there is no project `personas/` directory.
  2. The review skill's step-0 resolution finds nothing and the run stops there.
  3. Its message says the named persona could not be found and names both searched locations, the project `personas/` directory and the global `~/.config/jrit/personas/` library.
  4. It does not invent a persona, substitute a different one, or fall back to a default voice and review the draft anyway.
---

Use the review skill to check the draft at `status-update.md` in your current working directory against the persona named `night-shift-oncall`.
