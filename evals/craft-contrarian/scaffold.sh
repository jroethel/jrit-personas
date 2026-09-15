#!/usr/bin/env bash
# Seeds the run workspace with the voice persona from the plugin tree and this case's own
# negative-control audience fixture, so craft resolves both from the project personas/
# directory instead of reading them out of the prompt.
set -eu
here="$(cd "$(dirname "$0")" && pwd)"
mkdir -p personas
cp "$here/../../personas/architecture-reviewer.md" personas/architecture-reviewer.md
cp "$here/fixtures/detail-first-audience.md" personas/detail-first-audience.md
