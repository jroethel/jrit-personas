#!/usr/bin/env bash
# Proves skills/new/SKILL.md authors the seats format, and that the three authoring evals
# state a seat instead of the retired kind field.
set -uo pipefail
cd "$(dirname "$0")/.." || { echo "FAIL: cannot reach repo root" >&2; exit 1; }
fail() { echo "FAIL: $1" >&2; exit 1; }
S=skills/new/SKILL.md
grep -qE '`kind` (is|\()' "$S" && fail "new still names the retired kind field"
for anchor in '`seats`' '`creator`' '`reviewer`' '`audience`' '## As creator' '## As reviewer' '## As audience' \
              'Produces:' 'Emphasizes:' 'Approves:' 'Wants to see:' "Doesn't want to see:" 'Feedback style:' \
              'Wants first:' 'jargon-tolerance' 'docs/persona-format.md'; do
  grep -qF -- "$anchor" "$S" || fail "new SKILL.md is missing anchor: $anchor"
done
for f in evals/new-terse/prompt.md evals/new-terse/graders/schema-valid.md evals/new-ambiguous/prompt.md \
         evals/first-run-library/prompt.md; do
  grep -qE '`kind`|^kind:|kind `agent`|`agent` persona' "$f" && fail "$f still uses the retired kind field"
done
grep -qF '`creator`' evals/new-terse/prompt.md || fail "new-terse prompt must state the creator seat"
grep -qF '`creator`' evals/new-ambiguous/prompt.md || fail "new-ambiguous prompt must state the creator seat"
grep -qF '`creator`' evals/first-run-library/prompt.md || fail "first-run-library prompt must state the creator seat"
grep -qF 'seats' evals/new-terse/graders/schema-valid.md || fail "schema-valid grader must require seats"
echo "PASS: skill_new"
