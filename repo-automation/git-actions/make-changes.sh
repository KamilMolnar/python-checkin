#!/usr/bin/env bash
set -euo pipefail

# Script vytvori/prehodi obsah suboru zmeny.txt nahodnym obsahom
OUT_FILE="../zmeny.txt"

NOW="$(date '+%Y-%m-%d %H:%M:%S')"
RAND_NUM="$RANDOM"
HASH="$(printf '%s' "${NOW}-${RAND_NUM}" | sha256sum | awk '{print $1}')"

{
  echo "ZMENY GENEROVANE:"
  echo "Cas:  ${NOW}"
  echo "Rand: ${RAND_NUM}"
  echo "Hash: ${HASH}"
} > "$OUT_FILE"

echo "OK: Vytvorene/aktualizovane: $OUT_FILE"
