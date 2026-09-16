---
max_turns: 12
allowed_tools: [Skill, Read, Write, Bash]
expected_outcome: |
  1. The global library under `~/.config/jrit/personas/` does not exist when the run starts; the scaffold asserts that.
  2. The new skill creates the library rather than failing on its absence, per the first-use rule in `references/resolution.md`.
  3. It writes the persona `release-notes-editor` into the global library, not into a project `personas/` directory.
  4. Its closing message states the absolute path of the file it created, under a `.config/jrit/personas/` directory, and says the library had to be created.
  5. Every trait in the description is labeled `stated`, so no confirm pass runs and the file is written in the same turn.
---

Create a persona for me and keep it in my personal library, not in this project.
This is a brand new machine, so I do not think that library exists yet.
Then tell me the exact full path of the file you created.

Here is the whole description, and I have stated every trait outright, so take each one exactly as written and do not infer or default anything.

Name it `release-notes-editor`. It is an `agent` persona.

Stance. Role: edits the release notes before every ship. Expertise: changelog conventions, user-visible versus internal changes, and what a customer actually needs to be told. Viewpoint: a release note exists for the person deciding whether to upgrade. Cares about: plain naming of breaking changes, an upgrade path, and nothing shipped as a surprise.

Voice. Warmth: warm. Opinionatedness: opinionated. Formality: casual. Emotional awareness: task-focused.

Author and owner are both `Dana Okafor`. Derivation source: this description.
