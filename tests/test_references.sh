#!/usr/bin/env bash
# Proves the shared references carry their load-bearing anchors and no em dash.
set -uo pipefail
cd "$(dirname "$0")/.." || { echo "FAIL: cannot reach repo root" >&2; exit 1; }
fail() { echo "FAIL: $1" >&2; exit 1; }
VF=references/voice-framework.md
RES=references/resolution.md

for anchor in Warmth Opinionatedness Formality "Emotional awareness" \
              "voice, not substance" "explicit beats implicit"; do
  grep -qiF "$anchor" "$VF" || fail "voice-framework.md is missing anchor: $anchor"
done
for bin in stated inferred defaulted; do
  grep -qiwF "$bin" "$VF" || fail "voice-framework.md must name the '$bin' bin"
done
grep -qiF "confidence" "$VF" && fail "voice-framework.md must not reintroduce numeric confidence scoring"

grep -qF 'personas/' "$RES" || fail "resolution.md must describe the project personas/ directory"
grep -qF '~/.config/jrit/personas/' "$RES" || fail "resolution.md must name the global library"
grep -qiF "shadow" "$RES" || fail "resolution.md must state that a project persona shadows a global one"

em=$(printf '\xe2\x80\x94')
for f in "$VF" "$RES"; do
  grep -qF "$em" "$f" && fail "$f contains an em dash; house style is plain '-'"
done
echo "PASS: references"
