#!/bin/bash
pathLog="/var/log/ssm.log"
function cargar () {
	LNG=$(cat LANG.)
	. LANG/$LNG/LANG.sh
	printf "$lin1\n"
}
function cargarest () {
	LNG=en
	. LANG/$LNG/LANG.sh
	printf "$lin2\n"
}
LNG=$(cat LANG.)
if [ $? = 0 ]; then
	. LANG/$LNG/LANG.sh
	printf "$lin1\n"
else 
	echo "$LANG" | head -c2 >> LANG.
	case "$(cat LANG.)" in
		ca)
			cargar
			;;
		es)
			cargar
			;;
		*)
			cargarest
			;;
	esac
fi
contador=0
while [[ contador -lt 10 ]]; do
	. menu.sh
	if [[ $contador != 10 ]]; then
		. LANG/change.sh
	fi
done
