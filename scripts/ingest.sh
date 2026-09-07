#!/usr/bin/env bash
set -euo pipefail

GARDEN_DIR="$(cd "$(dirname "$0")/.." && pwd)/digital-garden"
NOTES_DIR="$GARDEN_DIR/notes"

usage() {
    cat <<EOF
Usage: $(basename "$0") [OPTIONS]

Create a new garden note with proper Kavu frontmatter and wikilinks.

Options:
  -t, --title TITLE       Note title (required)
  -s, --status STATUS     seeding|growing|evergreen (default: seeding)
  -T, --tags TAGS         Comma-separated tags
  -S, --source URL        Source URL for attribution
  -l, --links NOTES       Comma-separated note titles to wikilink
  -e, --edit              Open in \$EDITOR after creation
  -h, --help              Show this help

Examples:
  $(basename "$0") -t "Memory Management in Linux" -T "linux,kernel" -s seeding
  $(basename "$0") -t "CFS Scheduler" -S "https://example.com/article" -l "Linux Kernel Development"
EOF
    exit 0
}

title=""
status="seeding"
tags=""
source_url=""
links=""
open_editor=false

while [[ $# -gt 0 ]]; do
    case "$1" in
        -t|--title)  title="$2"; shift 2 ;;
        -s|--status) status="$2"; shift 2 ;;
        -T|--tags)   tags="$2"; shift 2 ;;
        -S|--source) source_url="$2"; shift 2 ;;
        -l|--links)  links="$2"; shift 2 ;;
        -e|--edit)   open_editor=true; shift ;;
        -h|--help)   usage ;;
        *)           echo "Unknown option: $1"; usage ;;
    esac
done

if [[ -z "$title" ]]; then
    echo "Error: --title is required"
    exit 1
fi

if [[ ! "$status" =~ ^(seeding|growing|evergreen)$ ]]; then
    echo "Error: status must be seeding|growing|evergreen"
    exit 1
fi

# Generate slug from title
slug=$(echo "$title" | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9]/-/g; s/--*/-/g; s/^-//; s/-$//')
filepath="$NOTES_DIR/$slug.md"

if [[ -f "$filepath" ]]; then
    echo "Error: $slug.md already exists"
    exit 1
fi

# Build tags array
tags_yaml="[]"
if [[ -n "$tags" ]]; then
    tags_yaml="[$(echo "$tags" | sed 's/[[:space:]]*,[[:space:]]*/", "/g; s/^/"/; s/$/"/' )]"
fi

today=$(date +%Y-%m-%d)

# Write the note
{
    echo "---"
    echo "title: \"$title\""
    echo "date: $today"
    echo "lastmod: $today"
    echo "draft: false"
    echo "tags: $tags_yaml"
    echo "summary: \"\""
    echo "status: \"$status\""
    echo "type: \"note\""
    echo "---"
    echo ""

    # Add source attribution if provided
    if [[ -n "$source_url" ]]; then
        echo "> Source: $source_url"
        echo ""
    fi

    # Add wikilinks section if links provided
    if [[ -n "$links" ]]; then
        echo ""
        echo "## Related"
        echo ""
        IFS=',' read -ra link_array <<< "$links"
        for link in "${link_array[@]}"; do
            link=$(echo "$link" | sed 's/^ *//; s/ *$//')
            echo "- [[$link]]"
        done
        echo ""
    fi
} > "$filepath"

echo "✓ Created: notes/$slug.md"
echo "  Title:  $title"
echo "  Status: $status"
[[ -n "$tags" ]] && echo "  Tags:   $tags"
[[ -n "$source_url" ]] && echo "  Source: $source_url"
[[ -n "$links" ]] && echo "  Links:  $links"

if $open_editor && [[ -n "${EDITOR:-}" ]]; then
    "$EDITOR" "$filepath"
fi
