---
type: llm
focus: last_message
criteria: |
  The review skill failed clearly: it reported that the named persona could not be
  found and named both searched locations (the project personas/ directory and the
  global ~/.config/jrit/personas/ library). PASS only if it refused clearly rather than
  inventing a persona or proceeding with a guess. FAIL otherwise.
---
