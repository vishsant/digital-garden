#!/usr/bin/env bash
# Build the digital garden: convert wikilinks, run Hugo, restore sources.
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$REPO_ROOT"

./scripts/convert-wikilinks.sh
hugo "$@"
git checkout -- digital-garden/
