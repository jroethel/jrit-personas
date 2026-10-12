#!/usr/bin/env bash
# Proves the persona-reference skill owns the shared text and every persona skill loads it by
# skill, with no parent-directory path that a symlinked skill folder would break.
set -euo pipefail
cd "$(dirname "$0")/.."
fail() { echo "FAIL: $1"; exit 1; }
R=skills/persona-reference
grep -q '^name: persona-reference$' $R/SKILL.md || fail "persona-reference name"
for t in resolution voice-framework persona-format; do
  test -s $R/references/$t.md || fail "missing $R/references/$t.md"
  grep -qF "\`references/$t.md\`" $R/SKILL.md || fail "SKILL.md table omits $t"
done
grep -qF '## Topic: check' $R/SKILL.md || fail "check topic missing"
for s in craft new review spawn; do
  f=skills/persona-$s/SKILL.md
  grep -qF 'persona-reference' "$f" || fail "$f does not load persona-reference"
  grep -qF '../' "$f" && fail "$f still has a parent-directory path"
done
test -d references && fail "stale top-level references/ directory"
echo "PASS: skill_reference"
