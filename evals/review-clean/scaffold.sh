#!/usr/bin/env bash
# Seeds the run workspace with the leadership-audience persona and the aligned draft to
# review, so the review skill resolves a real on-disk persona by name (per
# references/resolution.md) instead of being handed persona content inline.
set -eu
mkdir -p personas
cp "$(dirname "$0")/../../personas/leadership-audience.md" personas/
cp "$(dirname "$0")/fixtures/aligned-draft.md" .
