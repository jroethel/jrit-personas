#!/usr/bin/env bash
# Proves skills/review/SKILL.md carries the seats contract: two fit checks plus the
# approver mode read from the reviewer seat, with jargon judged by the format's definitions.
set -uo pipefail
cd "$(dirname "$0")/.." || { echo "FAIL: cannot reach repo root" >&2; exit 1; }
fail() { echo "FAIL: $1" >&2; exit 1; }
S=skills/review/SKILL.md
grep -qiF 'out of scope for v1' "$S" && fail "review still declares the persona's own review out of scope"
grep -qF '`kind`' "$S" && fail "review still names the retired kind field"
grep -qE 'both searched locations|neither location' "$S" && fail "review still describes the two-location search"
for anchor in '`creator`' '`reviewer`' '`audience`' '## As reviewer' '## As audience' 'Wants first:' \
              'Wants to see:' "Doesn't want to see:" 'Feedback style:' 'jargon-tolerance' 'banned-jargon' \
              'docs/persona-format.md' 'never gates' 'retired `kind:` key' 'no `jargon-tolerance`' \
              'every searched location' 'jargon not judged: no audience persona named'; do
  grep -qF -- "$anchor" "$S" || fail "review SKILL.md is missing anchor: $anchor"
done
E=evals/review-approver
for f in case.yaml scaffold.sh prompt.md fixtures/draft.md graders/approver-read.md; do
  test -f "$E/$f" || fail "eval case file missing: $E/$f"
done
echo "PASS: skill_review"
