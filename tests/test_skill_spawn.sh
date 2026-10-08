#!/usr/bin/env bash
# Proves skills/spawn/SKILL.md refuses a persona without the creator seat and gives the
# generated agent the universal jargon rule.
set -uo pipefail
cd "$(dirname "$0")/.." || { echo "FAIL: cannot reach repo root" >&2; exit 1; }
fail() { echo "FAIL: $1" >&2; exit 1; }
S=skills/spawn/SKILL.md
grep -qF '`kind`' "$S" && fail "spawn still names the retired kind field"
grep -qE 'both searched locations|neither location' "$S" && fail "spawn still describes the two-location search"
for anchor in '`seats`' '`creator`' '## As creator' 'jargon matches the reader of whatever it writes' \
              'retired `kind:` key' 'every searched location'; do
  grep -qF -- "$anchor" "$S" || fail "spawn SKILL.md is missing anchor: $anchor"
done
echo "PASS: skill_spawn"
