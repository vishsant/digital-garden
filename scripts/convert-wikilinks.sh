#!/usr/bin/env bash
# Convert [[wikilinks]] to standard Markdown links in-place before Hugo build.
# Builds a title→slug map from all notes, then replaces:
#   [[Note Title]]            → [Note Title](/digital-garden/notes/note-slug/)
#   [[Note Title|display]]    → [display](/digital-garden/notes/note-slug/)
# Unresolved wikilinks are left as-is (rendered as plain text).
#
# This modifies files in-place. Run `git checkout -- digital-garden/` after
# Hugo build to restore originals, or use scripts/build.sh which does both.

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
CONTENT_DIR="${1:-$REPO_ROOT/digital-garden/notes}"

declare -A title_to_slug

for f in "$CONTENT_DIR"/*.md; do
  [ -f "$f" ] || continue
  slug="$(basename "$f" .md)"
  title="$(sed -n 's/^title: *"\(.*\)"/\1/p' "$f" | head -1)"
  [ -n "$title" ] && title_to_slug["$title"]="$slug"
done

for f in "$CONTENT_DIR"/*.md; do
  [ -f "$f" ] || continue
  changed=false
  content="$(cat "$f")"

  for title in "${!title_to_slug[@]}"; do
    slug="${title_to_slug[$title]}"
    link_target="/digital-garden/notes/$slug/"

    # [[Title|display text]] → [display text](link)
    if grep -qF "[[${title}|" <<< "$content"; then
      content="$(sed "s#\[\[${title}|\([^]]*\)\]\]#[\1](${link_target})#g" <<< "$content")"
      changed=true
    fi

    # [[Title]] → [Title](link)
    if grep -qF "[[${title}]]" <<< "$content"; then
      content="$(sed "s#\[\[${title}\]\]#[${title}](${link_target})#g" <<< "$content")"
      changed=true
    fi
  done

  if [ "$changed" = true ]; then
    printf '%s\n' "$content" > "$f"
    echo "converted: $(basename "$f")"
  fi
done
