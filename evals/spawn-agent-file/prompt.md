---
max_turns: 10
allowed_tools: [Skill, Read, Write]
---
Spawn a subagent from the `architecture-reviewer` persona in this project.

Write the agent file to `agents/architecture-reviewer.md` instead of the usual `.claude/agents/` location: this workspace denies writes under any `.claude/` directory, so that is the destination for this run.

## Expected behavior

1. The agent resolves the persona to the project file `personas/architecture-reviewer.md` and states that path.
2. It writes one subagent file to `agents/architecture-reviewer.md`.
3. The subagent file's system prompt carries the persona's stance: its role as an architecture reviewer, its expertise, and what it cares about (scalability, robustness, maintainability).
4. The subagent file's system prompt carries the persona's voice: opinionated and clinical, formal, task-focused.
5. The stance and voice are embedded in the file, not referenced: the file names no persona library path and no absolute path.
