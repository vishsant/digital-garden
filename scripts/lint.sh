#!/usr/bin/env bash
set -euo pipefail

GARDEN_DIR="$(cd "$(dirname "$0")/.." && pwd)/digital-garden"
NOTES_DIR="$GARDEN_DIR/notes"

RED='\033[0;31m'
YELLOW='\033[0;33m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m'

errors=0
warnings=0

heading() { echo -e "\n${BOLD}${CYAN}── $1 ──${NC}"; }
error()   { echo -e "  ${RED}✗${NC} $1"; ((errors++)) || true; }
warn()    { echo -e "  ${YELLOW}!${NC} $1"; ((warnings++)) || true; }
ok()      { echo -e "  ${GREEN}✓${NC} $1"; }

# Collect all note files
mapfile -t notes < <(find "$NOTES_DIR" -name '*.md' -type f 2>/dev/null)

if [[ ${#notes[@]} -eq 0 ]]; then
    echo "No notes found in $NOTES_DIR"
    exit 0
fi

echo -e "${BOLD}Garden lint: ${#notes[@]} notes${NC}"

# ── 1. Frontmatter checks ──
heading "Frontmatter"

for note in "${notes[@]}"; do
    name=$(basename "$note" .md)
    rel="${note#$GARDEN_DIR/}"

    if ! head -1 "$note" | grep -q '^---$'; then
        error "$rel: missing frontmatter"
        continue
    fi

    fm=$(sed -n '/^---$/,/^---$/p' "$note" | sed '1d;$d')

    if ! echo "$fm" | grep -q '^title:'; then
        error "$rel: missing title"
    fi
    if ! echo "$fm" | grep -q '^date:'; then
        error "$rel: missing date"
    fi
    if ! echo "$fm" | grep -q '^status:'; then
        error "$rel: missing status"
    else
        status=$(echo "$fm" | grep '^status:' | sed 's/status: *"\{0,1\}\([^"]*\)"\{0,1\}/\1/')
        if [[ ! "$status" =~ ^(seeding|growing|evergreen)$ ]]; then
            error "$rel: invalid status '$status' (must be seeding|growing|evergreen)"
        fi
    fi
done

ok_fm=$((${#notes[@]} - errors))
[[ $errors -eq 0 ]] && ok "All notes have valid frontmatter"

# ── 2. Dead links ──
heading "Internal links"

declare -A note_titles
declare -A note_basenames
for note in "${notes[@]}"; do
    name=$(basename "$note" .md)
    note_basenames["$name"]=1
    title=$(sed -n '/^---$/,/^---$/p' "$note" | grep '^title:' | sed 's/title: *"\{0,1\}\([^"]*\)"\{0,1\}/\1/')
    if [[ -n "$title" ]]; then
        note_titles["$title"]=1
    fi
done

dead_links=0
for note in "${notes[@]}"; do
    rel="${note#$GARDEN_DIR/}"
    # Check [[wikilinks]]
    while IFS= read -r link; do
        target=$(echo "$link" | sed 's/|.*//')
        if [[ -z "${note_basenames[$target]:-}" ]] && [[ -z "${note_titles[$target]:-}" ]]; then
            kebab=$(echo "$target" | tr '[:upper:]' '[:lower:]' | tr ' ' '-')
            if [[ -z "${note_basenames[$kebab]:-}" ]]; then
                warn "$rel: dead link [[$link]] → no matching note"
                ((dead_links++)) || true
            fi
        fi
    done < <(grep -oP '\[\[\K[^\]]+' "$note" 2>/dev/null || true)
    # Check markdown links to /notes/slug/
    while IFS= read -r slug; do
        slug=$(echo "$slug" | sed 's|/$||')
        if [[ -n "$slug" ]] && [[ -z "${note_basenames[$slug]:-}" ]]; then
            warn "$rel: dead link /notes/$slug/ → no matching note"
            ((dead_links++)) || true
        fi
    done < <(grep -oP '\(/notes/\K[^)]+' "$note" 2>/dev/null || true)
done

[[ $dead_links -eq 0 ]] && ok "No dead internal links"

# ── 3. Orphan notes ──
heading "Orphans"

declare -A linked_notes
# Scan all notes + _index.md for outgoing links
for src in "${notes[@]}" "$GARDEN_DIR/_index.md"; do
    [[ -f "$src" ]] || continue
    while IFS= read -r link; do
        target=$(echo "$link" | sed 's/|.*//')
        linked_notes["$target"]=1
        kebab=$(echo "$target" | tr '[:upper:]' '[:lower:]' | tr ' ' '-')
        linked_notes["$kebab"]=1
    done < <(grep -oP '\[\[\K[^\]]+' "$src" 2>/dev/null || true)
    # Also catch markdown links to /notes/
    while IFS= read -r path; do
        name=$(echo "$path" | sed 's|/$||; s|.*/||')
        [[ -n "$name" ]] && linked_notes["$name"]=1
    done < <(grep -oP '\(/notes/\K[^)]+' "$src" 2>/dev/null || true)
done

orphans=0
for note in "${notes[@]}"; do
    name=$(basename "$note" .md)
    title=$(sed -n '/^---$/,/^---$/p' "$note" | grep '^title:' | sed 's/title: *"\{0,1\}\([^"]*\)"\{0,1\}/\1/')
    if [[ -z "${linked_notes[$name]:-}" ]] && [[ -z "${linked_notes[$title]:-}" ]]; then
        warn "$name: orphan (no incoming links)"
        ((orphans++)) || true
    fi
done

[[ $orphans -eq 0 ]] && ok "No orphan notes"

# ── 4. Stale seedlings ──
heading "Stale seedlings"

stale=0
today=$(date +%s)
for note in "${notes[@]}"; do
    rel="${note#$GARDEN_DIR/}"
    fm=$(sed -n '/^---$/,/^---$/p' "$note" | sed '1d;$d')
    status=$(echo "$fm" | grep '^status:' | sed 's/status: *"\{0,1\}\([^"]*\)"\{0,1\}/\1/')
    if [[ "$status" == "seeding" ]]; then
        note_date=$(echo "$fm" | grep '^date:' | sed 's/date: *"\{0,1\}\([0-9-]*\)"\{0,1\}/\1/')
        if [[ -n "$note_date" ]]; then
            note_ts=$(date -d "$note_date" +%s 2>/dev/null || echo 0)
            age_days=$(( (today - note_ts) / 86400 ))
            if [[ $age_days -gt 30 ]]; then
                warn "$rel: seeding for ${age_days} days — time to grow or prune?"
                ((stale++)) || true
            fi
        fi
    fi
done

[[ $stale -eq 0 ]] && ok "No stale seedlings (>30 days)"

# ── 5. Hugo build check ──
heading "Hugo build"

cd "$(dirname "$0")/.."
build_output=$(hugo 2>&1)
if [[ $? -eq 0 ]]; then
    pages=$(echo "$build_output" | grep 'Pages' | awk '{print $NF}')
    ok "Build clean ($pages pages)"
else
    error "Hugo build failed"
    echo "$build_output" | tail -5
fi

# ── Summary ──
echo -e "\n${BOLD}Summary:${NC} ${#notes[@]} notes, ${RED}${errors} errors${NC}, ${YELLOW}${warnings} warnings${NC}"
exit $([[ $errors -gt 0 ]] && echo 1 || echo 0)
