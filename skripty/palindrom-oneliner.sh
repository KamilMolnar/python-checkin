#!/usr/bin/env bash
[[ "$1" == "$(echo "$1" | rev)" ]] && echo "je palindrom" || echo "nie je palindrom"

