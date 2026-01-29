#!/usr/bin/env bash

# presun procesu do pozadia, id procesu.

#pockaj 5 sekund ale odloz proces do pozadia (&)
sleep 5 &

echo "last process id is $!"
#$! - id naposledy spusteneho procesu 
ps -ef | grep "$!" | grep -v grep

#exit code procesov
# o - ok "Vrati True, prikaz je uspesny"
# cokolvek okrem 0 (najcastejsie 1) "vrati False, prikaz zlyhal"
echo "vypysovanie exit codu posledneho procesu"
echo "$?" # 0, vysledok predosleho echa

#porovname ci 5=6
#ak je exit code command test 0 (ak vysledok podmienky je pravdivy) , spusti sa &&
#ak je exit code command test 1,2,3..... (ak vysledok podmienky je nepravdivy) , spusti sa ||
test 5 -eq 6 &&
 {echo "$?"}
  echo "bol spusteny kod v sekcii &&"
} || { #kvazi else
	echo "$?"
	

 || {echo "$?"}
