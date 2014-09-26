#!/bin/bash
contador1=1
./
while [ $contador1 -lt 10 ]; do
	clear
	tput cup 2 2
	tput rev
	/bin/echo "____________________________________________________________"
	tput cup 3 2
	/bin/echo "__"
	tput cup 4 2
	/bin/echo "__"
	tput cup 4 8
	tput sgr0 rev
	/bin/echo "Sethyan Service Manager"
	tput cup 4 30
	/bin/date +%a\ %d\ de\ %B\ de\ %Y
	tput cup 5 2
	tput rev
	/bin/echo "__"
	tput cup 6 2
	/bin/echo "__"
	tput cup 6 8
	tput sgr0 rev
	/bin/echo "Elija el servicio que va a implementar:"
	tput cup 7 2
	tput rev
	/bin/echo "__"
	tput cup 8 2
	/bin/echo "__"
	tput cup 8 8
	tput sgr0 rev
	/bin/echo "a)Servidor DNS"
	tput cup 8 28
	/bin/echo "i)Configurar archivo interfaces"
	tput cup 9 2
	tput rev
	/bin/echo "__"
	tput cup 9 8
	tput sgr0 rev
	/bin/echo "b)Servidor DHCP"
	tput cup 10 2
	tput rev
	/bin/echo "__"
	tput cup 10 8
	tput sgr0 rev
	/bin/echo "c)Servidor proxy-caché"
	tput cup 11 2
	tput rev
	/bin/echo "__"
	tput cup 11 8
	tput sgr0 rev
	/bin/echo "d)Servidor SSH"
	tput cup 12 2
	tput rev
	/bin/echo "__"
	tput cup 12 8
	tput sgr0 rev
	/bin/echo "e)Servidor FTP"
	tput cup 13 2
	tput rev
	/bin/echo "__"
	tput cup 13 28
	tput sgr0 rev
	/bin/echo "q)Salir del programa"
	tput cup 14 2
	tput rev
	/bin/echo "__"
	tput cup 15 2
	/bin/echo "__"
	tput cup 15 8
	tput sgr0 rev
	/bin/echo "Elija aquí su opción (a,b,c,d,e,i,q)"
	tput cup 16 2
	tput rev
	/bin/echo "__"
	tput cup 17 2
	/bin/echo "__"
	tput cup 18 2
	tput rev
	/bin/echo "____________________________________________________________"
	tput cup 16 8
	tput sgr0 rev
	read -p Op: -n 1 op
	case $op in
		"a")
			date>>$pathLog
			echo "Entrando en configuración del DNS">>$pathLog
			. bindmanager/menu.sh
			;;
		"i")
			date>>$pathLog
			echo "Entrando en configuración de fichero INTERFACES">>$pathLog
			clear
			. interfaces.sh
			;;
		"b")
			date>>$pathLog
			echo "Entrando en configuración del DHCP">>$pathLog
			. dhcpmanager/menu.sh
			;;
		"q")
			contador1=10
			contador=10
			;;
		"l")
			contador1=10
			contador=5
			;;
		*)
			date>>$pathLog
			echo "Por favor, seleccione DNS, DHCP o INTERFACES">>$pathLog
			;;
	esac
clear
done
