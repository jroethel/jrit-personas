---
type: llm
focus: {source: file, path: "agents/architecture-reviewer.md"}
criteria: |
  Read the created subagent file under the project's agents directory. Its system prompt
  embeds the architecture-reviewer persona's stance (role, expertise, what it cares
  about) and its voice (opinionated, clinical). PASS only if both stance and voice are
  present in the file and no absolute path to an external persona library is referenced.
  FAIL if it references a library path instead of embedding, or drops stance or voice.
---
