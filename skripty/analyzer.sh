#!/bin/bash

# Zapnutie prísnej kontroly chýb
set -eu

# Voliteľný debug režim
if [[ "${3-}" == "--debug" ]]; then
  set -x
fi

# Kontrola argumentov
if [[ $# -lt 2 ]]; then
  echo "Chyba: Zadaj cestu k suboru a parameter --type=log alebo --type=csv."
  exit 2
fi

INPUT_FILE="$1"
TYPE="$2"

# Kontrola existencie súboru
if [[ ! -f "$INPUT_FILE" ]]; then
  echo "Chyba: Subor '$INPUT_FILE' neexistuje."
  exit 2
fi

# Výpis základných informácií o skripte
echo "Skript: $0"
echo "Spracovavam subor: $INPUT_FILE"
echo ""

# Rozhodnutie podľa typu súboru
case "$TYPE" in
  --type=log)
    echo "Analyzujem LOG subor..."
    echo ""

    # Počet riadkov
    line_count=$(wc -l < "$INPUT_FILE")

    # Počet výskytov týchto reťazcov
    err_count=$(grep -c "ERROR" "$INPUT_FILE" || true)
    warn_count=$(grep -c "WARNING" "$INPUT_FILE" || true)
    info_count=$(grep -c "INFO" "$INPUT_FILE" || true)

    # Vytvorenie reportu
    {
      echo "===== LOG REPORT ====="
      echo "Pocet riadkov: $line_count"
      echo "ERROR: $err_count"
      echo "WARNING: $warn_count"
      echo "INFO: $info_count"
      echo ""
      echo "Prvych 5 riadkov:"
      head -n 5 "$INPUT_FILE"
      echo ""
      echo "Poslednych 5 riadkov:"
      tail -n 5 "$INPUT_FILE"
    } > log_report.txt

    # Výpis chyby alebo OK pomocou &&
    [[ "$err_count" -gt 0 ]] && echo "Chyby najdene v LOG subore." || echo "Bez chyb."

    echo ""
    echo "Vysledok ulozeny do log_report.txt"
    exit 0
    ;;

  --type=csv)
    echo "Analyzujem CSV subor..."
    echo ""

    # Odstránenie prázdnych riadkov
    sed '/^[[:space:]]*$/d' "$INPUT_FILE" > csv_clean.txt

    # Počet záznamov bez hlavičky
    total_lines=$(wc -l < csv_clean.txt)
    data_count=$((total_lines - 1))

    # Výpis tretieho stĺpca do súboru
    awk -F, 'NR>1 {print $3}' csv_clean.txt > csv_col3_values.txt

    # Priemer tretieho stĺpca
    avg=$(awk -F, 'NR>1 && $3 ~ /^[0-9]+$/ {sum+=$3; count++} END {if (count>0) print sum/count; else print 0}' csv_clean.txt)

    # Počítanie číselných a nečíselných hodnôt v stĺpci
    numeric=0
    nonnumeric=0
    while IFS=, read -r id name value; do
      if [[ "$value" =~ ^[0-9]+$ ]]; then
        numeric=$((numeric + 1))
      else
        nonnumeric=$((nonnumeric + 1))
      fi
    done < <(tail -n +2 csv_clean.txt)

    # Uloženie výsledku
    {
      echo "===== CSV REPORT ====="
      echo "Pocet zaznamov: $data_count"
      echo "Priemer hodnot (3. stlpec): $avg"
      echo "Ciselnych hodnot: $numeric"
      echo "Neciselnych hodnot: $nonnumeric"
    } > csv_report.txt

    echo "Vysledok ulozeny do csv_report.txt"
    exit 0
    ;;

  *)
    echo "Chyba: Neznamy parameter '$TYPE'. Pouzi --type=log alebo --type=csv."
    exit 1
    ;;
esac

