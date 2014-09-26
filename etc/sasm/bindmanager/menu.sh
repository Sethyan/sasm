#!/bin/bash
pathLog="/var/log/ssm.log"
contador2=1
while [ $contador2 -lt 10 ]; do
	clear
	tput cup 2 4
	tput rev
	/bin/echo "______________________________________________"
	tput cup 3 4
	/bin/echo "__"
	tput cup 3 48
	/bin/echo "__"
	tput cup 4 4
	/bin/echo "__"
	tput cup 4 8
	tput sgr0 rev
	/bin/echo "BINDMANAGER"
	tput cup 4 26
	/bin/date +%a\ %d\ de\ %B\ de\ %Y
	tput cup 4 48
	tput rev
	/bin/echo "__"
	tput cup 5 4
	/bin/echo "__"
	tput cup 5 48
	/bin/echo "__"
	tput cup 6 4
	/bin/echo "__"
	tput cup 6 8
	tput sgr0 rev
	/bin/echo "Elija el servicio que va a implementar:"
	tput cup 6 48
	tput rev
	/bin/echo "__"
	tput cup 7 4
	/bin/echo "__"
	tput cup 7 48
	/bin/echo "__"
	tput cup 8 4
	/bin/echo "__"
	tput cup 8 8
	tput sgr0 rev
	/bin/echo "a)Servidor principal"
	tput cup 8 48
	tput rev
	/bin/echo "__"
	tput cup 9 4
	/bin/echo "__"
	tput cup 9 8
	tput sgr0 rev
	/bin/echo "b)Servidor secundario"
	tput cup 9 48
	tput rev
	/bin/echo "__"
	tput cup 10 4
	/bin/echo "__"
	tput cup 10 8
	tput sgr0 rev
	/bin/echo "c)Configurar relación DNS-DHCP"
	tput cup 10 48
	tput rev
	/bin/echo "__"
	tput cup 11 4
	/bin/echo "__"
	tput cup 11 8
	tput sgr0 rev
	/bin/echo "d)Borrar configuración total o parcial"
	tput cup 11 48
	tput rev
	/bin/echo "__"
	tput cup 12 4
	/bin/echo "__"
	tput cup 12 48
	/bin/echo "__"
	tput cup 13 4
	/bin/echo "__"
	tput cup 13 8
	tput sgr0 rev
	/bin/echo "q)Volver al menú Sethyan Server Manager"
	tput cup 13 48
	tput rev
	/bin/echo "__"
	tput cup 14 4
	/bin/echo "__"
	tput cup 14 48
	/bin/echo "__"
	tput cup 15 4
	/bin/echo "__"
	tput cup 15 8
	tput sgr0 rev
	/bin/echo "Elija aquí su opción (a,b,c,d,q):"
	tput cup 15 48
	tput rev
	/bin/echo "__"
	tput cup 16 4
	/bin/echo "__"
	tput cup 16 48
	/bin/echo "__"
	tput cup 17 4
	/bin/echo "__"
	tput cup 17 48
	/bin/echo "__"
	tput cup 18 4
	/bin/echo "______________________________________________"
	tput cup 16 8
	tput sgr0 rev
	/bin/echo "Op:"
	tput cup 16 11
	read op
	if [ $op = "a" ]; then
		/bin/date>>$pathLog
		/bin/echo "Entrando en configuración del servidor primario">>$pathLog
		clear
		. bindmanager/SP.sh
	elif [ $op = "b" ]; then
		/bin/date>>$pathLog
		/bin/echo "Entrando en configuración del servidor secundario">>$pathLog
	elif [ $op = "c" ]; then
		. bindmanager/SS.sh
		/bin/date>>$pathLog
		/bin/echo "Entrando en configuración del enrutamiento">>$pathLog
		exec /etc/ssm/bindmanager/-
	elif [ $op = "d" ]; then
		/bin/date>>$pathLog
		/bin/echo "Borrar elemento/s">>$pathLog
		exec /etc/ssm/bindmanager/del/menu.sh
	elif [ $op = "q" ]; then 
		/bin/date>>$pathLog
		/bin/echo "Volviendo al menú Sethyan Server Manager"
		contador2=10
	fi
done
#exec /etc/ssm/menu.sh