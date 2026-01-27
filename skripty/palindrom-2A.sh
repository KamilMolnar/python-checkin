#!/usr/bin/env bash

# rozdelim slovo na polovicu, druhu otocim, a porovnam

#input 2 sposoby
#1. sposob (pochopitelnejsi):
read -p "zadaj slovo:" slovo

##2. sposob (menej CPU):
##slovo="$1"

#pocet pismen v slove 2.sposoby

#pocet_pismen="$(echo -n "$slovo" | wc --chars)"

pocet_pismen=${#slovo}

is_pal=1
for (( i=0; i<pocet_pismen/2; i++ )); do
	lava_strana=${slovo:$i:1}
	prava_strana=${slovo:$(( pocet_pismen - i - 1 )):1}
	if [[ $prava_strana != $lava_strana ]]; then
		is_pal=0
		break
	fi
done

	if [[ $is_pal -eq 1 ]]; then
	echo "Slovo '$slovo' je palindrom."
	else
	echo "Slovo '$slovo' nie je palindrom."
fi


#test $is_pal -eq 1  && echo "je palindrom" || echo "nie je palindrom"
