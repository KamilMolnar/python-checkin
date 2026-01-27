#!/usr/bin/env bash
set -euo pipefail

DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$DIR"

./make-changes.sh
./push-changes.sh
./fetch-changes.sh

echo "OK: Vsetky git-actions skripty prebehli."
