#!/usr/bin/env bash
# ci/run-all.sh - the single offline dev gate: structure, format, references, then
# plugin validation when the claude binary is present.
#
# The live-model eval suite is deliberately NOT run here. It needs an authenticated
# model and costs money per run, and this gate has to stay fast and offline so CI can
# run it on every push. The suite command is printed at the end instead; running it is
# the pre-merge acceptance step, done locally.
set -uo pipefail
cd "$(dirname "$0")/.." || { echo "FAIL: cannot reach the repo root" >&2; exit 1; }

fail() { echo "RUN-ALL FAIL: $1" >&2; exit 1; }

for s in ci/structure-check.sh tests/test_persona_format.sh tests/test_references.sh; do
  echo "== $s"
  bash "$s" || fail "$s exited non-zero"
done

if command -v claude >/dev/null 2>&1; then
  echo "== claude plugin validate --strict ."
  claude plugin validate --strict . || fail "claude plugin validate --strict . failed"
else
  echo "skip: claude plugin validate --strict . (claude binary not on PATH)"
fi

cat <<'EOF'

PASS: all
The eval suite is not part of this gate. Run it locally before merging:
  claude plugin eval evals --trust-plugin --no-publish --scaffold --allow-tools Write Bash
EOF
