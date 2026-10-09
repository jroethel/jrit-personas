---
type: llm
focus: last_message
criteria: |
  The draft is already aligned to the leadership-audience persona. The review must
  actually run: it states which mode it ran (or which persona cue settled the mode) and
  gives a verdict, either no misalignments found or an explicit statement that the
  draft is aligned. PASS only if a review was produced and it raises no fabricated
  callout. FAIL if it stopped to ask a question instead of reviewing, or if it invents
  any misalignment (for example claiming a buried summary, banned jargon, or wrong
  altitude that is not present), which would show the skill emits boilerplate
  complaints regardless of the artifact.
---
