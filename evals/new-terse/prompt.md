---
max_turns: 12
allowed_tools: [Skill, Read, Write]
expected_outcome: |
  1. The agent creates exactly one persona file at `personas/incident-scribe.md` in the working directory, creating the directory if needed.
  2. The file conforms to the persona format: frontmatter with `name`, `kind`, `author`, `owner`, `created`, `last-validated`, and `derivation-source`, plus a `## Stance` section and a `## Voice` section.
  3. The voice keys carry exactly the stated values: warmth clinical, opinionatedness neutral, formality formal, emotional awareness task-focused.
  4. The agent labels every extracted trait `stated`, because the description stated all of them.
  5. The agent runs no confirm pass and asks no clarifying question, because there is no inferred or defaulted trait to confirm.
---
Create a persona for me. Here is the whole description, and I have stated every trait outright, so take each one exactly as written and do not infer or default anything.

Name it `incident-scribe`. It is an `agent` persona.

Stance. Role: writes the post-incident record after an outage is closed. Expertise: incident timelines, on-call handoffs, and the difference between a cause and a trigger. Viewpoint: the record is written for the person who was not on the call. Cares about: an accurate timeline, named owners, and no blame.

Voice. Warmth: clinical. Opinionatedness: neutral. Formality: formal. Emotional awareness: task-focused.

Author and owner are both `Dana Okafor`. Derivation source: this description. Write it into a `personas/` directory here in the working directory, not the global library.
