---
type: llm
focus: last_message
criteria: |
  The craft skill wrote the deliverable with leadership-audience as the voice and
  architecture-reviewer as the reader. PASS only if all of these hold: both resolved
  persona paths are stated; a deliverable recommending for or against the distributed
  cache is produced; nothing in the reply says either persona lacks a seat or cannot sit
  in the role it was named for. FAIL if it refused either persona, stopped to ask which
  seat a persona holds, or produced no deliverable.
---
