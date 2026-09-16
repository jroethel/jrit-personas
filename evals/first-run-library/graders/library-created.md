---
type: llm
focus: last_message
criteria: |
  The new skill reported that it created the global library (previously absent) and
  wrote a persona into it, stating an absolute path under a .config/jrit/personas/
  directory. PASS only if it created the library and stated the created path. FAIL if
  it errored on the missing library or stated no path.
---
