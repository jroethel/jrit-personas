---
type: llm
focus: last_message
criteria: |
  The craft skill refused to write because the personas sit in the wrong seats, and it
  named the missing seat for each one: leadership-audience lacks the creator seat and
  architecture-reviewer lacks the audience seat. PASS only if both gaps are named and no
  deliverable (no recommendation about the distributed cache) is produced. FAIL if it
  wrote any deliverable, fell back to a default voice or reader, or named only one gap.
---
