---
max_turns: 10
allowed_tools: [Skill, Read]
expected_outcome: |
  1. The review skill searches for the persona named `data-analyst` in the order `references/resolution.md` sets: the project `personas/` directory first (absent in this run, a miss), then the user library under `~/.config/jrit/personas/`, and only then the distributed plugin library.
  2. Two different personas carry that name in this run: the user-tier copy the scaffold seeded and the distributed copy the plugin ships in its own `personas/` directory, so the search order decides which one is used.
  3. The skill states the resolved path in its output, and the path it states is the user-tier `~/.config/jrit/personas/data-analyst.md`.
  4. The review that follows is judged against the user persona (the overnight reconciliation checker who demands a row count beside every figure), not the distributed persona (the advancement data team analyst).
---

Use the review skill to check the draft at `reconciliation-note.md` in your current working directory against the persona named `data-analyst`.
Tell me which persona file you used.
