---
name: persona-reference
description: >-
  Returns jrit-personas shared reference text on request, so the other persona skills read one copy: topic resolution (where personas live), voice-framework (the four voice axes), persona-format (the persona file format), or check (report whether the persona setup is wired as expected). Loaded by persona-craft, persona-new, persona-review, and persona-spawn, or run directly to verify the install.
---

# Persona reference

One home for the text the persona skills share.
The files sit in this skill's `references/` folder, so every read below is local and needs no `..` path.

## Topics

Read the file for the requested topic from this skill's folder and use its content in full.

| Topic            | File                              | What it holds                                              |
|------------------|-----------------------------------|------------------------------------------------------------|
| resolution       | `references/resolution.md`        | The four-tier search order for a persona name              |
| voice-framework  | `references/voice-framework.md`   | The four voice axes and the personality-by-artifact matrix |
| persona-format   | `references/persona-format.md`    | The persona file format, derived seats, and the jargon keys |

A topic outside this table is an error: say which topics exist and stop.
When a calling skill asks for a topic, return the file content to it and continue the caller's step.
Do not summarize the file, because the callers apply its exact wording.

## Topic: check

Report whether the persona setup is wired as the other persona skills expect.
Report only, change nothing.

1. Confirm the three files above exist in this skill's `references/` folder.
2. Report each resolution tier and whether it exists on disk:
   - project: `personas/` in the current directory.
   - user: `~/.config/jrit/personas/`.
   - team: the `team-inventory-home:` line in `~/.config/jrit/inventory-pointer.md`, then its `personas/` directory. Report "not configured" when the key is absent or blank.
   - distributed: run `realpath "<this skill's folder>/../../personas"` in a shell, so the symlink resolves before the `..` does, and report whether that directory exists and how many `.md` files it holds.
3. Report the folder this skill was loaded from, so a linked install and a plugin install are told apart.
4. End with one line: `persona setup: ok` when the three files and the distributed tier exist, otherwise `persona setup: broken` naming each missing item.
