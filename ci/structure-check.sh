#!/usr/bin/env bash
# ci/structure-check.sh - the four structural checks over the shipped tree.
# Spec of record: plan 2026-09-15, Task 10 Behavior.
#
# Scope is what git tracks, enumerated with `git ls-files`. That excludes gitignored
# runtime output (evals/results/) and untracked scratch files for free, so the gate
# judges the shipped tree and never a local run artifact.
#
# Every failure names the file and the rule; no check ever exits 1 bare.
set -uo pipefail
cd "$(dirname "$0")/.." || { echo "FAIL: cannot reach the repo root" >&2; exit 1; }

fail() { echo "STRUCTURE FAIL: $1" >&2; exit 1; }
ok() { printf 'ok: %s\n' "$1"; }

EM=$(printf '\xe2\x80\x94')

# tracked <pathspec>... - tracked files under the given paths, NUL-free one per line.
tracked() { git ls-files -- "$@"; }

# ---------------------------------------------------------------------------
# Check A: every skills/*/SKILL.md opens with a --- frontmatter fence carrying
# name: and description:. Without those two keys the skill does not register.
# ---------------------------------------------------------------------------
check_a() {
  local f found=0
  while IFS= read -r f; do
    found=1
    [ "$(sed -n '1p' "$f")" = '---' ] \
      || fail "check A: $f line 1 is not the opening --- frontmatter fence"
    local close
    close=$(sed -n '2,$p' "$f" | grep -n -- '^---$' | sed -n '1s/:.*//p')
    [ -n "$close" ] || fail "check A: $f frontmatter fence never closes"
    local fm
    fm=$(sed -n "2,${close}p" "$f")
    printf '%s\n' "$fm" | grep -q '^name:' \
      || fail "check A: $f frontmatter is missing a 'name:' key"
    printf '%s\n' "$fm" | grep -q '^description:' \
      || fail "check A: $f frontmatter is missing a 'description:' key"
  done < <(tracked 'skills/*/SKILL.md')
  [ "$found" = 1 ] || fail "check A: no tracked skills/*/SKILL.md found"
  ok "A - every skills/*/SKILL.md opens with name: and description: frontmatter"
}

# ---------------------------------------------------------------------------
# Check B: no em dash character in any shipped markdown. House style is plain '-'.
# ---------------------------------------------------------------------------
check_b() {
  local hits
  hits=$(tracked 'skills/*.md' 'skills/**/*.md' 'references/*.md' 'docs/**/*.md' \
                 'docs/*.md' 'personas/*.md' 'README.md' \
         | xargs -r grep -nF -- "$EM" 2>/dev/null || true)
  [ -z "$hits" ] || fail "check B: em dash character found; house style is plain '-':
$hits"
  ok "B - no em dash in shipped markdown under skills/, references/, docs/, personas/, README.md"
}

# ---------------------------------------------------------------------------
# Check C: no absolute path in a persona file or a reference. Personas and
# references are portable text that must read the same on any machine.
# ---------------------------------------------------------------------------
check_c() {
  local hits
  hits=$(tracked 'personas/*.md' 'references/*.md' \
         | xargs -r grep -n -- '/home/' 2>/dev/null || true)
  [ -z "$hits" ] || fail "check C: absolute path found in a persona or reference; these files must stay portable:
$hits"
  ok "C - no absolute path in personas/ or references/"
}

# ---------------------------------------------------------------------------
# Check D: every persona in personas/ passes the dev-time format check.
# ---------------------------------------------------------------------------
check_d() {
  local p found=0
  while IFS= read -r p; do
    found=1
    bash ci/check-persona-format.sh "$p" \
      || fail "check D: $p fails ci/check-persona-format.sh (its ERROR line is above)"
  done < <(tracked 'personas/*.md')
  [ "$found" = 1 ] || fail "check D: no tracked personas/*.md found"
  ok "D - every persona in personas/ passes ci/check-persona-format.sh"
}

check_a
check_b
check_c
check_d
echo "PASS: structure"
