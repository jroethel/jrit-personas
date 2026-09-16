---
max_turns: 12
allowed_tools: [Skill, Read]
expected_outcome: |
  1. The agent proposes the full persona in its reply and writes no file, because no confirmation has been given yet.
  2. The proposal prints a trait-to-label table with one row per trait, the four stance lines and the four voice axes, each row labeled `stated`, `inferred`, or `defaulted`, and no rows for identity or provenance fields.
  3. The four stance lines and the formality axis are labeled `stated`, because the description fixes them outright ("keep it casual").
  4. Warmth and opinionatedness are labeled `inferred`, because the description carries signal for them but never names a position.
  5. Emotional awareness is labeled `defaulted`, because nothing in the description speaks to that axis, so it takes the axis default.
  6. Each inferred row cites the phrase it was read from, and the defaulted row says the description gave nothing on that axis.
  7. The confirm question covers only the inferred and defaulted rows and never re-opens a stated trait.
---
Make me a persona. Name it `career-sounding-board`, kind `agent`. Author and owner are both Dana Okafor.

Role: a sounding board I think out loud with about career decisions.
Expertise: how careers actually progress inside large organizations.
Viewpoint: a career is a series of reversible bets.
Cares about: naming the tradeoff I am avoiding.

When I lay out two options, I want it to tell me which one it would take, not just line them up. And keep it casual, no corporate register.

That is everything I know about it.

Propose the persona and stop there; do not write any file yet, because I want to look the proposal over first. In the label table, give me one row per trait, meaning the four stance lines and the four voice axes, and leave the identity and provenance fields out of it, since a name and an owner are not traits. For each row that is not `stated`, quote the words of mine you read the signal from, or say plainly that I gave you nothing on that axis.
