#!/usr/bin/env bash
# Proves skills/craft/SKILL.md carries the seats contract: a creator voice, an audience reader,
# Wants first driving lead order, and jargon judged by the format's definitions.
set -uo pipefail
cd "$(dirname "$0")/.." || { echo "FAIL: cannot reach repo root" >&2; exit 1; }
fail() { echo "FAIL: $1" >&2; exit 1; }
S=skills/craft/SKILL.md
grep -qE '`kind`|`agent` kind|`audience` kind' "$S" && fail "craft still names the retired kind field"
grep -qE 'both searched locations|neither location' "$S" && fail "craft still describes the two-location search"
for anchor in '`creator`' '`audience`' '## As creator' '## As audience' 'Produces:' 'Emphasizes:' \
              'Wants first:' 'jargon-tolerance' 'banned-jargon' 'docs/persona-format.md' \
              'retired `kind:` key' 'no `jargon-tolerance`' 'every searched location'; do
  grep -qF -- "$anchor" "$S" || fail "craft SKILL.md is missing anchor: $anchor"
done
E=evals/craft-seat-refusal
for f in case.yaml scaffold.sh prompt.md graders/seats-refused.md; do
  test -f "$E/$f" || fail "eval case file missing: $E/$f"
done
echo "PASS: skill_craft"
