#!/usr/bin/env bash
set -euo pipefail

# Spustaj z: repo-automation/git-actions
REPO_DIR="$(cd .. && pwd)"
cd "$REPO_DIR"

BRANCH="$(git rev-parse --abbrev-ref HEAD)"

# Pridaj zmeny (primarne zmeny.txt, ale kludne berieme vsetko)
git add -A

# Ak nic nezmenene, neskusaj commit
if git diff --cached --quiet; then
  echo "INFO: Ziadne zmeny na commit."
  exit 0
fi

MSG="Auto update zmeny.txt - $(date '+%Y-%m-%d %H:%M:%S')"
git commit -m "$MSG"

# Push (ak je branch prvykrat bez upstreamu, nastav ho)
if git rev-parse --abbrev-ref --symbolic-full-name "@{u}" >/dev/null 2>&1; then
  git push
else
  git push -u origin "$BRANCH"
fi

echo "OK: Commit & push hotovy na branch: $BRANCH"
