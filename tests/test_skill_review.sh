#!/usr/bin/env bash
# Proves skills/persona-review/SKILL.md runs its three modes against any persona with no seat refusal,
# reads the optional seat sections, and judges jargon by the format's definitions.
set -uo pipefail
cd "$(dirname "$0")/.." || { echo "FAIL: cannot reach repo root" >&2; exit 1; }
fail() { echo "FAIL: $1" >&2; exit 1; }
S=skills/persona-review/SKILL.md
grep -qiF 'out of scope for v1' "$S" && fail "review still declares the persona's own review out of scope"
grep -qF '`kind`' "$S" && fail "review still names the retired kind field"
grep -qE 'both searched locations|neither location' "$S" && fail "review still describes the two-location search"
grep -qE 'seat is missing|lacks the seat|holds `creator`|holds `reviewer`|holds `audience`|seats: \[' "$S" \
  && fail "review still refuses a persona for a missing seat"
for anchor in '## As reviewer' '## As audience' 'Wants first:' 'Wants to see:' "Doesn't want to see:" \
              'Feedback style:' 'jargon-tolerance' 'banned-jargon' 'persona-format' 'never gates' \
              'retired `kind:` or `seats:` line' 'delete the line' 'no `jargon-tolerance`' \
              'every searched location' 'jargon not judged: no audience persona named' \
              'naming the three modes' 'Stance `Cares about:` only' 'the report says the section is absent'; do
  grep -qF -- "$anchor" "$S" || fail "review SKILL.md is missing anchor: $anchor"
done
E=evals/review-approver
for f in case.yaml scaffold.sh prompt.md fixtures/draft.md graders/approver-read.md; do
  test -f "$E/$f" || fail "eval case file missing: $E/$f"
done
grep -qw 'seats' "$E/prompt.md" "$E/graders/approver-read.md" && fail "review-approver still uses seats wording"
echo "PASS: skill_review"
