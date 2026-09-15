#!/usr/bin/env bash
# Seeds the run workspace with the architecture-reviewer starter persona.
# The case fixtures are not copied into the workspace by the harness, so this is how
# the persona reaches the project personas/ directory the skill resolves against.
set -eu
here="$(cd "$(dirname "$0")" && pwd)"
mkdir -p personas
cp "$here/../../personas/architecture-reviewer.md" personas/architecture-reviewer.md
