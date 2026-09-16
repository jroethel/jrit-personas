#!/usr/bin/env bash
# Asserts the first-run precondition rather than seeding anything: the run's global library
# must not exist yet, so the run proves the skill creates it. HOME is provided by the
# harness; never re-export it.
set -eu

if [ -e "$HOME/.config/jrit/personas" ]; then
  echo "ERROR: the global library already exists in this run's HOME; the first-run case needs it absent" >&2
  exit 1
fi
