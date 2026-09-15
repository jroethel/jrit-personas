#!/usr/bin/env bash
# Proves ci/check-persona-format.sh accepts valid personas and rejects malformed ones.
set -u
cd "$(dirname "$0")/.." || { echo "FAIL: cannot reach repo root" >&2; exit 1; }
fail() { echo "FAIL: $1" >&2; exit 1; }

bash ci/check-persona-format.sh tests/fixtures/valid-agent.md \
  || fail "valid-agent.md should validate (exit 0)"
bash ci/check-persona-format.sh tests/fixtures/valid-audience.md \
  || fail "valid-audience.md should validate (exit 0)"

if bash ci/check-persona-format.sh tests/fixtures/invalid-missing-name.md 2>/dev/null; then
  fail "invalid-missing-name.md should be rejected (nonzero exit)"
fi
if bash ci/check-persona-format.sh tests/fixtures/invalid-bad-kind.md 2>/dev/null; then
  fail "invalid-bad-kind.md should be rejected (nonzero exit)"
fi

# The rejection must name the problem, not just exit nonzero.
bash ci/check-persona-format.sh tests/fixtures/invalid-missing-name.md 2>&1 \
  | grep -qi 'name' || fail "rejection of a missing name must mention 'name'"

echo "PASS: persona_format"
