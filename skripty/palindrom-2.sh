#!/usr/bin/env bash

# rozdelim slovo na polovicu, druhu otocim, a porovnam

#input 2 sposoby
#1. sposob (pochopitelnejsi):
read -p "zadaj slovo:" slovo

##2. sposob (menej CPU):
##slovo="$1"

#pocet pismen v slove 2.sposoby

#pocet_pismen="$(echo -n "$slovo" | wc --chars)"

pocet_pismen="${#slovo}"

#parny pocet ? 2 moznosti

#if [  "$pocet_pismen" % 2 == 0 ]
#then
 # parny_pocet=true
#else
  #parny_pocet=false
#fi

#predelenie_dvomi="$(echo "scale=2; 9 / 2" | bc | awk -F'.' '{print $2}')"
#test "$predelenie_dvomi" -gt 0 && parny_pocet=true

obratene_slovo=""

#while read i; do
#	obratene_slovo="$obratene_slovo${slovo:$i:1}"
#done < <(seq $((pocet_pismen-1)) -1 0)

seq $((pocet_pismen-1)) -1 0 | while read i; do
	obratene_slovo="$obratene_slovo${slovo:$i:i}"
done

echo -n "Slovo ${slovo} "
if [ $slovo == $obratene_slovo ]; then
	echo " je palindrom"
else
	echo "nie je palindrom"
fi


#if [ "$parny_pocet" == "true" ]
#then
 # polovica_znakov=$(( $pocet_pismen / 2 ))
  #prva_polovica=${slovo::polovica_znakov}
  #druha_polovica=${slovo:$polovica_znakov}

  #echo "tvoje slovo je $prva_polovica - $druha_polovica"
#else
 #:
#fi

#otocena_druha=""

#for (( i=${#druha_polovica}-1; i>=0; i-- )); do
 #   otocena_druha="$otocena_druha${druha_polovica:$i:1}"
#done

#echo $otocena_druha

#vypise 1 znak -> echo -n ${var::1}
#odkroji 1 znak -> ${var::-1}
#vypise 1 posledny znak ${var:1}
