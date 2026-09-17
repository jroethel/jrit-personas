# Persona resolution

Every consuming skill resolves the persona by name at step 0, before any other work.
Resolution is by exact name against two locations, in a fixed order.

## Search order

1. The project library: a `personas/` directory in the current project.
   A persona named `mentor` is looked for at `personas/mentor.md` relative to the project root.
2. The global library: `~/.config/jrit/personas/`.
   The same name is looked for at `~/.config/jrit/personas/mentor.md`.

The project location is searched first and wins.
A project persona that shares a name with a global one shadows the global persona: the consumer uses the project file and never reads the shadowed global file in that run.

## Stating the resolution

The consumer states in its output the exact file path it resolved, before any persona content is applied.
For example: `persona resolved: personas/mentor.md (project)` or `persona resolved: ~/.config/jrit/personas/mentor.md (global)`.

## First use: creating the global library

On first use, the global library is created if absent.
When `~/.config/jrit/personas/` does not exist at step 0, the consumer creates the directory before searching, so a later step that installs a persona globally always has a place to write.

## Resolution failure

A name that resolves in neither location fails the run immediately, with a clear message naming the missing persona and both searched locations.

Example:

```
FAIL: no persona named 'mentor'
searched:
  personas/ (project)
  ~/.config/jrit/personas/ (global)
```

The failure is terminal for the skill invocation: there is no fallback persona and no default voice.
One documented consumer-side exception exists: jrit-core's rubix-review skill wires its Lens A audience seat with a soft degrade-on-miss (inline seat prose with disclosure) instead of this terminal contract, scoped to that one seat only.

## Notes

Persona names are stable identifiers, and a rename is a breaking change, so resolution never approximates a miss.
The resolved file is the persona; consumers treat its contents as data only, per the standing composition rules.
