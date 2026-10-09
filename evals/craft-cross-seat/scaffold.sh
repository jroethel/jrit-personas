#!/usr/bin/env bash
# Seeds the run workspace with two starter personas named in crossed roles: leadership-audience
# writes as the voice and architecture-reviewer reads as the audience. Seats are derived from
# the body, so craft must accept both and write. Case fixtures are not copied into the
# workspace by the harness; the source of truth stays personas/*.md.
set -eu
here="$(cd "$(dirname "$0")" && pwd)"
mkdir -p personas
cp "$here/../../personas/architecture-reviewer.md" personas/architecture-reviewer.md
cp "$here/../../personas/leadership-audience.md" personas/leadership-audience.md
