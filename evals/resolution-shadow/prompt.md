---
max_turns: 10
allowed_tools: [Skill, Read]
expected_outcome: |
  1. The review skill searches for the persona named `reviewer` in the order `references/resolution.md` sets: the project `personas/` directory first, then the global library under `~/.config/jrit/personas/`.
  2. Two different personas carry that name in this run, one in each location, so the search order decides which one is used.
  3. The skill states the resolved path in its output, and the path it states is the project-local `personas/reviewer.md`.
  4. The review that follows is judged against the project persona (the night-shift on-call reader), not the global persona (the compliance auditor).
---

Use the review skill to check the draft at `status-update.md` in your current working directory against the persona named `reviewer`.
Tell me which persona file you used.
