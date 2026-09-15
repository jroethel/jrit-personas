#!/usr/bin/env bash
# Seeds the run workspace with the two starter personas craft resolves against.
# Case fixtures are not copied into the workspace by the harness, so this copies the committed
# starters from the plugin tree into the run's project personas/ directory. No bytes are
# duplicated in this case dir: the source of truth stays personas/*.md.
set -eu
here="$(cd "$(dirname "$0")" && pwd)"
mkdir -p personas
cp "$here/../../personas/architecture-reviewer.md" personas/architecture-reviewer.md
cp "$here/../../personas/leadership-audience.md" personas/leadership-audience.md
