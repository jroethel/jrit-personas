---
type: llm
focus: {source: file, path: "personas/incident-scribe.md"}
criteria: |
  The created persona file conforms to docs/persona-format.md: frontmatter carries
  name (kebab-case), kind (agent or audience), author, owner, created and
  last-validated (YYYY-MM-DD), and derivation-source; the body has a ## Stance section
  and a ## Voice section, and each of the four voice keys holds an allowed value. PASS
  only if every required key and both body sections are present and well-formed. FAIL
  if any required field is missing or malformed.
---
