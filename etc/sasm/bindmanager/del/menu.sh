#!/bin/bash
pathLog="/var/log/ssm.log"
contador=1
while [ $contador -lt 10 ]; do
	clear
	tput cup 2 4
	tput rev
	/bin/echo "______________________________________________"
	tput cup 3 4
	/bin/echo "__"
	tput cup 4 4
	/bin/echo "__"
	tput cup 4 8
	tput sgr0 rev
	/bin/echo "Configuración"
	tput cup 4 24
	/bin/date +%a\ %d\ de\ %B\ de\ %Y
	tput rev
	tput cup 5 4
	/bin/echo "__"
	tput cup 5 8
	tput sgr0 rev
	/bin/echo "   Avanzada"
	tput rev
	tput cup 6 4
	/bin/echo "__"
	tput cup 6 8
	tput sgr0 rev
	/bin/echo "Seleccione el registro para añadir o"
	tput rev
	tput cup 7 4
	/bin/echo "__"
	tput cup 7 8
	tput sgr0 rev
	/bin/echo "borrar una linea del fichero:"
	tput rev
	tput cup 8 4
	/bin/echo "__"
	tput cup 8 8
	tput sgr0 rev
	/bin/echo "a)Registro NS"
	tput cup 8 28
	/bin/echo "f)Registro SRV"
	tput rev
	tput cup 9 4
	/bin/echo "__"
	tput cup 9 8
	tput sgr0 rev
	/bin/echo "b)Registro A"
	tput cup 9 28
	/bin/echo "g)Registro TXT"
	tput rev
	tput cup 10 4
	/bin/echo "__"
	tput cup 10 8
	tput sgr0 rev
	/bin/echo "c)Registro AAA"
	tput cup 10 28
	/bin/echo "h)Borrar linea"
	tput rev
	tput cup 11 4
	/bin/echo "__"
	tput cup 11 8
	tput sgr0 rev
	/bin/echo "d)Registro MX"
	tput rev
	tput cup 12 4
	/bin/echo "__"
	tput cup 12 8
	tput sgr0 rev
	/bin/echo "e)Registro CNAME"
	tput rev
	tput cup 13 4
	/bin/echo "__"
	tput cup 13 8
	tput sgr0 rev
	/bin/echo "q)Volver al menú Sethyan Server Manager"
	tput rev
	tput cup 14 4
	/bin/echo "__"
	tput cup 15 4
	/bin/echo "__"
	tput cup 15 8
	tput sgr0 rev
	/bin/echo "Elija aquí su opción (a,b,c,d,e,f,q):"
	tput rev
	tput cup 16 4
	/bin/echo "__"
	tput cup 17 4
	/bin/echo "__"
	tput cup 16 8
	tput sgr0 rev
	/bin/echo "Op:"
	tput cup 16 11
	read op
	if [ $op = "a" ]; then
		/bin/date>>$pathLog
		/bin/echo "Registro NS">>$pathLog
		clear
		exec /etc/ssm/bindmanager/del/NS.sh
	elif [ $op = "b" ]; then
		/bin/date>>$pathLog
		/bin/echo "Registro A">>$pathLog
	elif [ $op = "c" ]; then
		exec /etc/ssm/bindmanager/del/A.sh
		/bin/date>>$pathLog
		/bin/echo "Registro AAA">>$pathLog
		exec /etc/ssm/bindmanager/del/AAA.sh
	elif [ $op = "d" ]; then
		/bin/date>>$pathLog
		/bin/echo "Registro MX">>$pathLog
		exec /etc/ssm/bindmanager/del/MX.sh
	elif [ $op = "e" ]; then
		/bin/date>>$pathLog
		/bin/echo "Registro CNAME">>$pathLog
		exec /etc/ssm/bindmanager/del/CNAME.sh
	elif [ $op = "f" ]; then
		/bin/date>>$pathLog
		/bin/echo "Registro SRV">>$pathLog
		exec /etc/ssm/bindmanager/del/SRV.sh
	elif [ $op = "g" ]; then
		/bin/date>>$pathLog
		/bin/echo "Registro TXT">>$pathLog
		exec /etc/ssm/bindmanager/del/TXT.sh
	elif [ $op = "h" ]; then
		/bin/date>>$pathLog
		/bin/echo "Borrar linea">>$pathLog
		exec /etc/ssm/bindmanager/del/BL.sh
	elif [ $op = "q" ]; then 
		/bin/date>>$pathLog
		/bin/echo "Volviendo al menú Sethyan Server Manager"
		contador=10
	fi
done
exec /etc/ssm/bindmanager/menu.sh