#!/usr/bin/env bash
# Proves skills/persona-spawn/SKILL.md takes any persona, states its provenance before writing the
# agent file, and gives the generated agent the universal jargon rule.
set -uo pipefail
cd "$(dirname "$0")/.." || { echo "FAIL: cannot reach repo root" >&2; exit 1; }
fail() { echo "FAIL: $1" >&2; exit 1; }
S=skills/persona-spawn/SKILL.md
grep -qF '`kind`' "$S" && fail "spawn still names the retired kind field"
grep -qE 'both searched locations|neither location' "$S" && fail "spawn still describes the two-location search"
grep -qE 'Refuse a persona|holding the creator seat|holding the `creator` seat|`seats` does not hold|seats: \[' "$S" \
  && fail "spawn still refuses a persona without the creator seat"
for anchor in '## As creator' 'jargon matches the reader of whatever it writes' \
              'retired `kind:` or `seats:` line' 'delete the line' 'every searched location' \
              'Before writing the agent file, state' '`derivation-source`' '`last-validated`'; do
  grep -qF -- "$anchor" "$S" || fail "spawn SKILL.md is missing anchor: $anchor"
done
echo "PASS: skill_spawn"
