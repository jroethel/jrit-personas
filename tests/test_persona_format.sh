#!/usr/bin/env bash
# Proves ci/check-persona-format.sh accepts valid personas and rejects malformed ones,
# and that docs/persona-format.md carries the seats contract and the jargon definitions.
set -u
cd "$(dirname "$0")/.." || { echo "FAIL: cannot reach repo root" >&2; exit 1; }
fail() { echo "FAIL: $1" >&2; exit 1; }
CHECK=ci/check-persona-format.sh
FX=tests/fixtures

for f in valid-creator valid-audience valid-three-seats; do
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
reject invalid-kind 'kind is retired'
reject invalid-unknown-seat "unknown seat 'editor'"
reject invalid-empty-seats 'at least one seat'
reject invalid-audience-key-without-seat 'jargon-tolerance belongs to the audience seat'
reject invalid-section-without-seat "needs 'reviewer' in seats"
reject invalid-unknown-section "section '## As editor' names no seat"
reject invalid-label-in-wrong-section "'Approves:' does not belong in section '## As creator'"

# Only the negative kind fixture may still carry a kind: line.
hits=$(grep -l '^kind:' "$FX"/*.md | grep -vxF "$FX/invalid-kind.md" || true)
[ -z "$hits" ] || fail "only tests/fixtures/invalid-kind.md may carry a kind: line, found: $hits"

DOC=docs/persona-format.md
for anchor in '`seats`' '## As creator' '## As reviewer' '## As audience' \
              'Produces:' 'Emphasizes:' 'Approves:' 'Wants to see:' "Doesn't want to see:" \
              'Feedback style:' 'Wants first:' \
              '## Jargon' 'Jargon is any term' '- `low`:' '- `medium`:' '- `high`:' '- `banned-jargon`:' \
              'When `jargon-tolerance` is absent'; do
  grep -qF -- "$anchor" "$DOC" || fail "persona-format.md is missing anchor: $anchor"
done
grep -qE '^\| `kind` ' "$DOC" && fail "persona-format.md still lists kind as a frontmatter key"

echo "PASS: persona_format"
