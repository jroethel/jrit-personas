---
max_turns: 10
allowed_tools: [Skill, Read]
expected_outcome: |
  1. The agent resolves `leadership-audience` via the review skill's step-0 resolution rules and states the resolved file path (the project `personas/leadership-audience.md`).
  2. The draft already fits the persona: it leads with an executive summary, contains none of the banned-jargon terms, and stays at a cost, risk, and dates altitude throughout.
  3. The review reports no misalignments, or explicitly states the draft is aligned, rather than inventing a callout.
---

Use the review skill to review the draft at `aligned-draft.md` (relative to your current working directory) against the persona named `leadership-audience`.
