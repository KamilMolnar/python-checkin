#!/usr/bin/env bash
echo "zalomeny \
riadok"

echo "----- seriozna funkcia ----"
# funkcia ktora urcuje vaznost suboru

function vaznost_suboru() {
  local skore_vaznosti=0
  local nazov_suboru="$1"
  local obsah_suboru="$(cat "$nazov_suboru")"

  # 1️⃣ kľúčové slová
  echo "$obsah_suboru" | grep -i -e internal -e confidential >/dev/null 2>/dev/null && {
    skore_vaznosti=$(( skore_vaznosti + 2 ))
  }

  # 2️⃣ počet riadkov
  local pocet_riadkov_suboru="$(echo "$obsah_suboru" | wc -l)"
  skore_vaznosti=$(( skore_vaznosti + (pocet_riadkov_suboru / 10) ))

  # 3️⃣ práva súboru
  local prava="$(stat -c "%A" "$nazov_suboru")"
  # napr. -rwxr-xr--
  # indexy: [1-3]=owner, [4-6]=group, [7-9]=others
  for ((i=1; i<=3; i++)); do
    znak="${prava:$i:1}"
    [[ "$znak" == "r" ]] && skore_vaznosti=$(( skore_vaznosti + 1 ))
    [[ "$znak" == "w" ]] && skore_vaznosti=$(( skore_vaznosti + 10 ))
    [[ "$znak" == "x" ]] && skore_vaznosti=$(( skore_vaznosti + 5 ))
  done
  for ((i=4; i<=6; i++)); do
    znak="${prava:$i:1}"
    [[ "$znak" == "r" ]] && skore_vaznosti=$(( skore_vaznosti + 1 ))
    [[ "$znak" == "w" ]] && skore_vaznosti=$(( skore_vaznosti + 10 ))
    [[ "$znak" == "x" ]] && skore_vaznosti=$(( skore_vaznosti + 5 ))
  done
  for ((i=7; i<=9; i++)); do
    znak="${prava:$i:1}"
    [[ "$znak" == "r" ]] && skore_vaznosti=$(( skore_vaznosti + 1 ))
    [[ "$znak" == "w" ]] && skore_vaznosti=$(( skore_vaznosti + 10 ))
    [[ "$znak" == "x" ]] && skore_vaznosti=$(( skore_vaznosti + 5 ))
  done

  # 4️⃣ typ suboru (text vs binarny)
  local typ="$(file -b "$nazov_suboru")"
  local velkost="$(stat -c "%s" "$nazov_suboru")"
  if echo "$typ" | grep -qi "ASCII text"; then
    skore_vaznosti=$(( skore_vaznosti - 10 ))
  elif echo "$typ" | grep -qi "binary"; then
    priratat=$(( velkost / 10 ))
    skore_vaznosti=$(( skore_vaznosti + priratat ))
  fi

  # výstup
  echo "Subor: $nazov_suboru"
  echo "Vaznost: $skore_vaznosti"
}

echo "spustam vaznost suboru s prvym argumentom skriptu"
vaznost_suboru "$1"

