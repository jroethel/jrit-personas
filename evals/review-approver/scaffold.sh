#!/usr/bin/env bash
# Seeds only the training draft. No persona is copied: change-management-prosci ships in
# the plugin's own personas/ directory, and with no project or user copy in this run the
# review skill must resolve it from the distributed tier per references/resolution.md.
set -eu
cp "$(dirname "$0")/fixtures/draft.md" .
