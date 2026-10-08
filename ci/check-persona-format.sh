#!/usr/bin/env bash
# Dev-time persona format check against docs/persona-format.md.
# grep/sed only: no parser, no third-party dependency.
# Never invoked by a skill at runtime and never shipped as a runtime dependency.
# Exits 0 when the file conforms; otherwise prints one ERROR line to stderr and exits 1.
set -u
[ $# -eq 1 ] || { echo "ERROR: usage: ci/check-persona-format.sh <file>" >&2; exit 1; }
file=$1
[ -f "$file" ] || { echo "ERROR: file not found: $file" >&2; exit 1; }
err() { echo "ERROR: $1 in $file" >&2; exit 1; }

# Frontmatter fence: opens with --- on line 1, closes on a later line holding only ---.
[ "$(sed -n '1p' "$file")" = '---' ] || err "frontmatter must open with a --- line on line 1"
close=$(sed -n '2,$p' "$file" | grep -n -- '^---$' | sed -n '1s/:.*//p')
[ -n "$close" ] || err "frontmatter fence never closes"
fm=$(sed -n "2,${close}p" "$file" | sed 's/\r$//')
body=$(sed -n "$((close + 2)),\$p" "$file" | sed 's/\r$//')

fmval() { printf '%s\n' "$fm" | sed -n "s/^$1:[[:space:]]*//p" | sed -n '1p' | sed 's/[[:space:]]*$//'; }

printf '%s\n' "$fm" | grep -q '^kind:' \
  && err "kind is retired; replace it with seats (kind: agent becomes seats: [creator], kind: audience becomes seats: [audience])"

for key in name seats author owner created last-validated derivation-source; do
  printf '%s\n' "$fm" | grep -q -- "^$key:" || err "frontmatter is missing required key '$key'"
done

seats=$(fmval seats)
printf '%s\n' "$seats" | grep -qx '\[.*]' || err "seats must be a simple [a, b] list (found '$seats')"
seat_list=$(printf '%s\n' "$seats" | sed 's/^\[//; s/\]$//' | grep -o '[^,]*' \
  | sed 's/^[[:space:]]*//; s/[[:space:]]*$//' | grep -v '^$')
[ -n "$seat_list" ] || err "seats must list at least one seat from: creator, reviewer, audience"
while IFS= read -r seat; do
  printf '%s\n' "$seat" | grep -qxE 'creator|reviewer|audience' \
    || err "seats holds unknown seat '$seat'; allowed: creator, reviewer, audience"
done <<< "$seat_list"
has_seat() { printf '%s\n' "$seat_list" | grep -qx -- "$1"; }

for key in jargon-tolerance banned-jargon time-budget; do
  if printf '%s\n' "$fm" | grep -q -- "^$key:" && ! has_seat audience; then
    err "$key belongs to the audience seat; add audience to seats or remove $key"
  fi
done

name=$(fmval name)
printf '%s\n' "$name" | grep -qxE '[a-z0-9]+(-[a-z0-9]+)*' \
  || err "name must be kebab-case, ^[a-z0-9]+(-[a-z0-9]+)*$ (found '$name')"

for key in created last-validated; do
  d=$(fmval "$key")
  printf '%s\n' "$d" | grep -qxE '[0-9]{4}-[0-9]{2}-[0-9]{2}' \
    || err "$key must be a date as YYYY-MM-DD (found '$d')"
done

printf '%s\n' "$body" | grep -qx -- '## Stance' || err "body is missing the '## Stance' heading"
printf '%s\n' "$body" | grep -qx -- '## Voice' || err "body is missing the '## Voice' heading"

# Seat sections: each '## As <seat>' names a seat listed in seats.
while IFS= read -r sec; do
  printf '%s\n' "$sec" | grep -qxE 'creator|reviewer|audience' \
    || err "section '## As $sec' names no seat; allowed: creator, reviewer, audience"
  has_seat "$sec" || err "section '## As $sec' needs '$sec' in seats"
done < <(printf '%s\n' "$body" | sed -n 's/^## As //p' | sed 's/[[:space:]]*$//')

# Seat labels: every label line inside a '## As <seat>' section is one of that seat's labels.
sec=
while IFS= read -r line; do
  case $line in
    '## As '*) sec=$(printf '%s\n' "$line" | sed 's/^## As //; s/[[:space:]]*$//'); continue ;;
    '## '*) sec=; continue ;;
  esac
  [ -n "$sec" ] || continue
  label=$(printf '%s\n' "$line" | grep -oE "^[A-Z][A-Za-z' ]*:") || continue
  case $sec in
    creator) allowed="Produces:, Emphasizes:" ;;
    reviewer) allowed="Approves:, Wants to see:, Doesn't want to see:, Feedback style:" ;;
    audience) allowed="Wants first:, Cares about:" ;;
  esac
  case ", $allowed, " in
    *", $label, "*) ;;
    *) err "'$label' does not belong in section '## As $sec'; allowed: $allowed" ;;
  esac
done <<< "$body"

voice() {
  label=$1
  shift
  val=$(printf '%s\n' "$body" | sed -n "s/^$label:[[:space:]]*//p" | sed -n '1p' | sed 's/[[:space:]]*$//')
  [ -n "$val" ] || return 0
  for allowed in "$@"; do
    [ "$val" = "$allowed" ] && return 0
  done
  err "$label must be one of: $* (found '$val')"
}
voice 'Warmth' clinical warm playful
voice 'Opinionatedness' neutral opinionated
voice 'Formality' formal casual
voice 'Emotional awareness' task-focused emotionally-attentive

exit 0
