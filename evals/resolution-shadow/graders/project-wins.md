---
type: llm
focus: last_message
criteria: |
  The review skill stated that it resolved the persona named "reviewer" to the
  project-local ./personas/reviewer.md, not the global ~/.config/jrit/personas/ copy.
  PASS only if the stated resolved path is the project file. FAIL if it used the global
  copy or stated no path.
---
