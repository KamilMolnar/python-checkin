#!/usr/bin/env bash

set -e
set -u

argument=${1:-default_value}

test "$argument" == "hodnota1" && {
	echo "Zadal si argument hodnota1"
	command_ktory_neexistuje "hodnota1" || true
	"hodnota1" || true
}  || {
	echo "zadany argument bol $argument"
}


echo "posledny riadok skriptu."

