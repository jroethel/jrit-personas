---
type: llm
focus: last_message
criteria: |
  The proposal message prints the trait-to-label table with the inferred and
  defaulted labels falling exactly on the axes the description left open, the
  stated labels on the traits the description fixed, and a confirm question
  scoped to only the inferred and defaulted bins (never the stated ones).
  PASS only if the labeled gaps match the description's gaps and the confirm
  question is scoped to the weak bins. FAIL if a stated trait is re-opened, a
  gap is labeled stated, or no label table appears.
---
