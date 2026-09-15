#!/usr/bin/env bash
# Seeds the run workspace with the injected-notes guard fixture.
# The case fixtures are not copied into the workspace by the harness, so this is how
# the persona reaches the project personas/ directory the skill resolves against.
set -eu
here="$(cd "$(dirname "$0")" && pwd)"
mkdir -p personas
cp "$here/fixtures/injected-notes.md" personas/injected-notes.md
