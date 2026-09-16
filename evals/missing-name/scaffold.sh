#!/usr/bin/env bash
# Seeds an empty global library in the run's HOME and a draft to review, and asserts there is
# no project personas/ directory, so the requested name resolves in neither location.
# HOME is provided by the harness; never re-export it.
set -eu

mkdir -p "$HOME/.config/jrit/personas"

if [ -e personas ]; then
  echo "ERROR: a project personas/ directory exists; the missing-name case needs both locations empty" >&2
  exit 1
fi

cat > status-update.md <<'DRAFT'
# Ingest pipeline status

The nightly ingest job has been failing intermittently since Tuesday.
Roughly one run in three times out partway through the transform stage.
The team has been looking at connection pool exhaustion as the likely cause.
A fix is in review and should land this week.
Until then the morning reports may be up to six hours stale.
DRAFT
