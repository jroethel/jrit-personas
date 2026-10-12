#!/usr/bin/env bash
# Proves skills/persona-craft/SKILL.md takes any two personas with no seat refusal, applies the optional
# seat sections, and judges jargon by the format's definitions.
set -uo pipefail
cd "$(dirname "$0")/.." || { echo "FAIL: cannot reach repo root" >&2; exit 1; }
fail() { echo "FAIL: $1" >&2; exit 1; }
S=skills/persona-craft/SKILL.md
grep -qE '`kind`|`agent` kind|`audience` kind' "$S" && fail "craft still names the retired kind field"
grep -qE 'both searched locations|neither location' "$S" && fail "craft still describes the two-location search"
grep -qE 'no fallback|missing its seat|holds `creator`|holds `audience`|seats: \[' "$S" \
  && fail "craft still refuses a persona for a missing seat"
for anchor in 'the same persona may be both' '## As creator' '## As audience' 'Produces:' 'Emphasizes:' \
              'Wants first:' 'jargon-tolerance' 'banned-jargon' 'docs/persona-format.md' 'no `jargon-tolerance`' \
              'every searched location' 'retired `kind:` or `seats:` line' 'delete the line'; do
  grep -qF -- "$anchor" "$S" || fail "craft SKILL.md is missing anchor: $anchor"
done
test -e evals/craft-seat-refusal && fail "evals/craft-seat-refusal still exists; its premise is retired"
E=evals/craft-cross-seat
for f in case.yaml scaffold.sh prompt.md graders/cross-seat-written.md; do
  test -f "$E/$f" || fail "eval case file missing: $E/$f"
done
echo "PASS: skill_craft"
