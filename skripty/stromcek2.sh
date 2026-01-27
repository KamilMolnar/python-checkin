#!/bin/bash
read -p "Zadaj vysku stromceka: " vyska
 
if ! [[ "$vyska" =~ ^[1-9][0-9]*$ ]]; then
        echo "zadaj cele kladne cislo."
        exit 1
fi
 
for ((riadok=1; riadok<=vyska; riadok++)); do
        hviezdicky=$((2*riadok - 1))
        medzery=$((vyska - riadok))
 
        printf "%*s" "$medzery" ""
        printf "%*s\n" "$hviezdicky" | tr ' ' '*'
done
 
printf "%*s|\n" "$(( vyska - 1 ))" ""
