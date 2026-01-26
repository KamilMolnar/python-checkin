#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd .. && pwd)"
cd "$REPO_DIR"

BRANCH="$(git rev-parse --abbrev-ref HEAD)"

git fetch origin

# Bezpecnejsie a cistejsie historie:
git pull --rebase origin "$BRANCH"

# Alternativa (keby si chcel presne podla zadania):
# git rebase "origin/$BRANCH"

echo "OK: Fetch + pull(rebase) hotovy na branch: $BRANCH"
