---
max_turns: 10
allowed_tools: [Skill, Read]
---

Use the review skill to review the draft at `draft.md` (relative to your current working directory) against the persona named `leadership-audience`.

## Expected behavior

1. The agent resolves `leadership-audience` via the review skill's step-0 resolution rules and states the resolved file path (the project `personas/leadership-audience.md`).
2. The review calls out that the real executive-summary sentence is buried in the last section instead of leading the memo.
3. The review calls out the banned-jargon term "leverage" in the Team Impact section.
4. The review calls out that the Current Architecture and Proposed Technical Changes sections are pitched too deep in implementation detail (buffer sizes, index rebuild mechanics, cron times) for a leadership reader who wants cost, risk, and dates.
5. Each of the three callouts names or quotes the specific location in the draft, and all three are reported as distinct findings.
