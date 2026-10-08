#!/usr/bin/env bash
# Seeds the run workspace with two starter personas named in swapped roles, so craft's
# seat check has to refuse both: leadership-audience holds only the audience seat and
# architecture-reviewer holds only the creator seat. Case fixtures are not copied into
# the workspace by the harness; the source of truth stays personas/*.md.
set -eu
here="$(cd "$(dirname "$0")" && pwd)"
mkdir -p personas
cp "$here/../../personas/architecture-reviewer.md" personas/architecture-reviewer.md
cp "$here/../../personas/leadership-audience.md" personas/leadership-audience.md
