---
type: llm
focus: last_message
criteria: |
  The review skill stated that it resolved the persona named "data-analyst" to the
  user-tier ~/.config/jrit/personas/data-analyst.md, not the distributed copy shipped in
  the plugin's own personas/ directory. PASS only if the stated resolved path is the
  user-tier file. FAIL if it used the distributed copy or stated no path.
---
