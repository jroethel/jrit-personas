---
type: llm
focus: trace
criteria: |
  The agent created one persona file and, because the description stated every trait
  outright, it labeled all extracted traits as "stated" and ran no confirm pass
  (or an empty one). PASS if the trace shows all-stated labeling and no clarifying
  question about inferred or defaulted traits. FAIL if it invented an inferred or
  defaulted trait the description did not require, or skipped the file write.
---
