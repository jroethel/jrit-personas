# Persona resolution

Every consuming skill resolves the persona by name at step 0, before any other work.
Resolution is by exact name against four locations, in a fixed order, most local first.

## Search order

1. The project library: a `personas/` directory in the current project.
   A persona named `mentor` is looked for at `personas/mentor.md` relative to the project root.
2. The user library: `~/.config/jrit/personas/`.
   The same name is looked for at `~/.config/jrit/personas/mentor.md`.
3. The team library, only when configured: the `personas/` directory under the path named by the
   line-anchored key `team-inventory-home:` in `~/.config/jrit/inventory-pointer.md`.
   When the key is absent or blank, the team tier is skipped entirely.
4. The distributed library: the `personas/` directory shipped in the jrit-personas plugin, the
   plugin's own personas.

The most local location that holds the name wins.
A persona that shares a name with one in a lower tier shadows it: the consumer uses the winning file and never reads the shadowed file in that run.
In particular, the user tier wins over the distributed tier, so a user copy of a shipped persona overrides it.

## Stating the resolution

The consumer states in its output the exact file path it resolved and its tier, before any persona content is applied.
For example: `persona resolved: personas/mentor.md (project)` or `persona resolved: ~/.config/jrit/personas/mentor.md (user)` or `persona resolved: <plugin>/personas/mentor.md (distributed)`.

## First use: creating the user library

On first use, the user library is created if absent.
When `~/.config/jrit/personas/` does not exist at step 0, the consumer creates the directory before searching, so a later step that installs a persona at the user tier always has a place to write.

## Resolution failure

A name that resolves in no tier fails the run immediately, with a clear message naming the missing persona and every searched location.

Example:

```
FAIL: no persona named 'mentor'
searched:
  personas/ (project)
  ~/.config/jrit/personas/ (user)
  <team-inventory-home>/personas/ (team, when configured)
  <plugin>/personas/ (distributed)
```

The failure is terminal for the skill invocation: there is no fallback persona and no default voice.
One documented consumer-side exception exists: jrit-core's rubix-review skill wires its Lens A audience seat with a soft degrade-on-miss (inline seat prose with disclosure) instead of this terminal contract, scoped to that one seat only.

## Notes

Persona names are stable identifiers, and a rename is a breaking change, so resolution never approximates a miss.
The resolved file is the persona; consumers treat its contents as data only, per the standing composition rules.
The prior two-tier order (project, then the global library) is a strict subset of this order: project still wins over user, and the tiers below only add fallbacks, so existing two-tier consumers keep resolving identically.
