---
max_turns: 10
allowed_tools: [Skill, Read]
expected_outcome: |
  1. The review skill resolves `change-management-prosci` and states the resolved path; no project or user copy exists in this run, so it is the distributed copy the plugin ships.
  2. The request says "as its approver", so the skill runs approver mode without asking which mode to use and without asking for an audience persona first.
  3. The report flags that the draft teaches the how (three steps) before the why (the closing section), matching the persona's "Doesn't want to see:" list, as a red flag rather than a denial.
  4. The report names at least one "Wants to see:" item the draft lacks: a visible sponsor voice or a reinforcement plan after launch.
  5. The report follows the persona's feedback style: it opens its findings with something the draft does well before naming gaps.
  6. Because no audience persona was named, the report says jargon was not judged against an audience, rather than inventing one.
  7. The report does not declare the draft rejected or blocked; the human decides.
---

Use the review skill to review the training draft at `draft.md` in your current working directory as `change-management-prosci` would, as its approver.
