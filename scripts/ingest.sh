#!/usr/bin/env bash
set -euo pipefail

GARDEN_DIR="$(cd "$(dirname "$0")/.." && pwd)/digital-garden"
NOTES_DIR="$GARDEN_DIR/notes"
INBOX_DIR="$GARDEN_DIR/inbox"

usage() {
    cat <<EOF
Usage: $(basename "$0") [OPTIONS]

Create a new garden note, or promote an inbox note to the garden.

Modes:
  From scratch:   $(basename "$0") -t "Title" -T "tags" -s seeding
  From inbox:     $(basename "$0") -i inbox-note.md -T "tags" -l "Related Note"

Options:
  -i, --inbox FILE        Inbox file to promote (filename or path)
  -t, --title TITLE       Note title (required if not using --inbox)
  -s, --status STATUS     seeding|growing|evergreen (default: seeding)
  -T, --tags TAGS         Comma-separated tags
  -S, --source URL        Source URL for attribution
  -l, --links NOTES       Comma-separated note titles to wikilink
  -d, --delete            Delete inbox file after promotion
  -e, --edit              Open in \$EDITOR after creation
  -h, --help              Show this help

Examples:
  $(basename "$0") -t "Memory Management" -T "linux,kernel"
  $(basename "$0") -i cfs-notes.md -T "linux,scheduler" -l "Linux Kernel Development" -d
EOF
    exit 0
}

title=""
status="seeding"
tags=""
source_url=""
links=""
inbox_file=""
delete_inbox=false
open_editor=false

while [[ $# -gt 0 ]]; do
    case "$1" in
        -i|--inbox)  inbox_file="$2"; shift 2 ;;
        -t|--title)  title="$2"; shift 2 ;;
        -s|--status) status="$2"; shift 2 ;;
        -T|--tags)   tags="$2"; shift 2 ;;
        -S|--source) source_url="$2"; shift 2 ;;
        -l|--links)  links="$2"; shift 2 ;;
        -d|--delete) delete_inbox=true; shift ;;
        -e|--edit)   open_editor=true; shift ;;
        -h|--help)   usage ;;
        *)           echo "Unknown option: $1"; usage ;;
    esac
done

if [[ -z "$inbox_file" ]] && [[ -z "$title" ]]; then
    echo "Error: --title or --inbox is required"
    exit 1
fi

if [[ ! "$status" =~ ^(seeding|growing|evergreen)$ ]]; then
    echo "Error: status must be seeding|growing|evergreen"
    exit 1
fi

# ── Inbox promotion mode ──
if [[ -n "$inbox_file" ]]; then
    # Resolve inbox file path
    if [[ ! -f "$inbox_file" ]]; then
        inbox_file="$INBOX_DIR/$inbox_file"
    fi
    if [[ ! -f "$inbox_file" ]]; then
        echo "Error: inbox file not found: $inbox_file"
        exit 1
    fi

    # Derive title from filename if not provided
    basename_no_ext=$(basename "$inbox_file" .md)
    if [[ -z "$title" ]]; then
        # Convert kebab-case filename to Title Case
        title=$(echo "$basename_no_ext" | sed 's/-/ /g' | sed 's/\b\(.\)/\u\1/g')
    fi

    # Read the inbox note body (strip frontmatter if present)
    if head -1 "$inbox_file" | grep -q '^---$'; then
        body=$(sed '1,/^---$/{ /^---$/!d; }' "$inbox_file" | sed '1d')
    else
        body=$(cat "$inbox_file")
    fi
fi

# Generate slug
slug=$(echo "$title" | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9]/-/g; s/--*/-/g; s/^-//; s/-$//')
filepath="$NOTES_DIR/$slug.md"

if [[ -f "$filepath" ]]; then
    echo "Error: notes/$slug.md already exists"
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

    # Add source attribution if provided
    if [[ -n "$source_url" ]]; then
        echo ""
        echo "> Source: $source_url"
    fi

    # Add inbox body if promoting
    if [[ -n "$inbox_file" ]]; then
        echo "$body"
    else
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
    fi
} > "$filepath"

echo "✓ Created: notes/$slug.md"
echo "  Title:  $title"
echo "  Status: $status"
[[ -n "$tags" ]] && echo "  Tags:   $tags"
[[ -n "$source_url" ]] && echo "  Source: $source_url"
[[ -n "$links" ]] && echo "  Links:  $links"

if [[ -n "$inbox_file" ]]; then
    echo "  From:   $(basename "$inbox_file")"
    if $delete_inbox; then
        rm "$inbox_file"
        echo "  ✓ Deleted inbox file"
    else
        echo "  Inbox file kept (use -d to delete)"
    fi
fi

if $open_editor && [[ -n "${EDITOR:-}" ]]; then
    "$EDITOR" "$filepath"
fi
