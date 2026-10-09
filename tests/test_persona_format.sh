#!/usr/bin/env bash
# Proves ci/check-persona-format.sh accepts valid personas and rejects malformed ones,
# and that docs/persona-format.md carries the derived-seats contract and the jargon definitions.
set -u
cd "$(dirname "$0")/.." || { echo "FAIL: cannot reach repo root" >&2; exit 1; }
fail() { echo "FAIL: $1" >&2; exit 1; }
CHECK=ci/check-persona-format.sh
FX=tests/fixtures

for f in valid-plain valid-audience valid-audience-keys-no-sections valid-three-seats; do
  bash "$CHECK" "$FX/$f.md" || fail "$f.md should validate (exit 0)"
done

# reject <fixture-basename> <phrase only the intended rule prints>
# The ` in <file>` suffix is stripped before matching, so a fixture name can never satisfy the phrase.
reject() {
  local out
  if out=$(bash "$CHECK" "$FX/$1.md" 2>&1); then
    fail "$1.md should be rejected (nonzero exit)"
  fi
  printf '%s\n' "$out" | grep -q '^ERROR:' || fail "$1.md rejection must print an ERROR: line (got: $out)"
  printf '%s\n' "$out" | sed 's/ in [^ ]*$//' | grep -qF -- "$2" || fail "$1.md rejection must say '$2' (got: $out)"
}
reject invalid-missing-name "missing required key 'name'"
reject invalid-kind 'kind is retired; delete the line (seats are derived from the ## As <seat> sections)'
reject invalid-seats 'seats is retired; delete the line (seats are derived from the ## As <seat> sections)'
reject invalid-time-budget 'time-budget is retired; delete the line (no skill reads it)'
reject invalid-unknown-section "section '## As editor' names no seat"
reject invalid-label-in-wrong-section "'Approves:' does not belong in section '## As creator'"

# Only the two negative legacy fixtures may carry a kind: or seats: line.
hits=$(grep -lE '^(kind|seats):' "$FX"/*.md | grep -vxF -e "$FX/invalid-kind.md" -e "$FX/invalid-seats.md" || true)
[ -z "$hits" ] || fail "only invalid-kind.md and invalid-seats.md may carry a kind: or seats: line, found: $hits"

DOC=docs/persona-format.md
for anchor in 'Seats are derived' 'optional and additive' 'read when the persona sits as audience' \
              '## As creator' '## As reviewer' '## As audience' \
              'Produces:' 'Emphasizes:' 'Approves:' 'Wants to see:' "Doesn't want to see:" \
              'Feedback style:' 'Wants first:' \
              '## Jargon' 'Jargon is any term' '- `low`:' '- `medium`:' '- `high`:' '- `banned-jargon`:' \
              'When `jargon-tolerance` is absent'; do
  grep -qF -- "$anchor" "$DOC" || fail "persona-format.md is missing anchor: $anchor"
done
grep -qF 'audience seat only' "$DOC" && fail "persona-format.md still limits the audience keys to the audience seat"
grep -qE '^\| `(kind|seats|time-budget)` ' "$DOC" && fail "persona-format.md still lists a retired key as a frontmatter key"

# example <heading line> <fixture-basename>: the first fenced block under the heading equals the fixture.
example() {
  awk -v h="$1" '$0 == h {f = 1; next} f && /^```$/ {if (b) exit; b = 1; next} f && b' "$DOC" \
    | diff -q - "$FX/$2.md" >/dev/null || fail "persona-format.md example under '$1' differs from $FX/$2.md"
}
example '## Example: a persona with no seat sections' valid-plain
example '## Example: a persona with audience keys' valid-audience
example '## Example: a persona with all three seat sections' valid-three-seats

echo "PASS: persona_format"
