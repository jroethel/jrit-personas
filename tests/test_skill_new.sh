#!/usr/bin/env bash
# Proves skills/persona-new/SKILL.md asks which seat sections to write instead of authoring the retired
# seats key, and that the three authoring evals and the schema grader carry no retired key.
set -uo pipefail
cd "$(dirname "$0")/.." || { echo "FAIL: cannot reach repo root" >&2; exit 1; }
fail() { echo "FAIL: $1" >&2; exit 1; }
S=skills/persona-new/SKILL.md
grep -qE '`kind` (is|\()' "$S" && fail "new still names the retired kind field"
grep -qF '`seats`' "$S" && fail "new still authors the retired seats key"
for anchor in '## As creator' '## As reviewer' '## As audience' 'Produces:' 'Emphasizes:' 'Approves:' \
              'Wants to see:' "Doesn't want to see:" 'Feedback style:' 'Wants first:' 'jargon-tolerance' \
              'docs/persona-format.md' 'which `## As <seat>` sections' 'No `kind:` or `seats:` line'; do
  grep -qF -- "$anchor" "$S" || fail "new SKILL.md is missing anchor: $anchor"
done
for f in evals/new-terse/prompt.md evals/new-terse/graders/schema-valid.md evals/new-ambiguous/prompt.md \
         evals/first-run-library/prompt.md; do
  grep -qE '`kind`|^kind:|kind `agent`|`agent` persona|`seats`|only seat' "$f" && fail "$f still uses a retired key"
done
for f in evals/new-terse/prompt.md evals/new-ambiguous/prompt.md evals/first-run-library/prompt.md; do
  grep -qF 'needs no `## As <seat>` sections' "$f" || fail "$f must settle the seat sections up front"
done
grep -qF 'no kind or seats key' evals/new-terse/graders/schema-valid.md \
  || fail "schema-valid grader must require that no kind or seats key is present"
echo "PASS: skill_new"
