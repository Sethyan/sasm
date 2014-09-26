#!/bin/bash
#
#
clear
printf "MGRInterfaces\n"
printf " \n"
printf "¿Quiere reiniciar la configuración del archivo interfaces? (si/no)\n"
read named
if [ $named = si ]; then
	date>>$pathLog
	printf "reiniciando archivo interfaces\n">>$pathLog
	true > /etc/network/interfaces
	printf "auto lo\n">>/etc/network/interfaces
	printf "iface lo inet loopback\n">>/etc/network/interfaces
elif [ $named = no ]; then
	echo "no se reinicia nada"
fi
printf "creando archivo interfaces\n">>$pathLog
printf "Elija cuantas interficies va a configurar (1 o mas)"
contador="0"
read interfaces
while [ $contador -lt $interfaces ]; do
	date>>$pathLog
	printf "creando eth$contador\n">>$pathLog
	printf "seleccione si quiere 'dhcp' o 'static':\n"
	read dhst0
	if [ $dhst0 = "dhcp" ]; then
		printf "creando dhcp para eth$contador\n">>$pathLog
		printf "auto eth$contador\n">>/etc/network/interfaces
		printf "iface eth$contador inet dhcp\n">>/etc/network/interfaces
		printf "Realizado correctamente\n"
		cat "/etc/network/interfaces"
		printf "OK\n">>$pathLog
	elif [ $dhst0 = "static" ]; then
		printf "creando static para eth$contador\n">>$pathLog
		printf "auto eth$contador\n">>/etc/network/interfaces
		printf "iface eth$contador inet static\n">>/etc/network/interfaces
		printf "Especifique ip ejem: 192.168.20.11 (entera)\n"
		read ipinter0
		printf "address $ipinter0\n">>/etc/network/interfaces
		printf "Especifique mascara ejem: 24 '1/32'\n"
		read masc1
		if [ $masc1 = "0" ]; then
			masc2="0.0.0.0"
			echo "$masc2 en clase X un total de x redes y x hosts en cada"
		elif [ $masc1 = "1" ]; then
			masc2="128.0.0.0"
			echo "$masc2 en clase X un total de x redes y x hosts en cada"
		elif [ $masc1 = "2" ]; then
			masc2="192.0.0.0"
			echo "$masc2 en clase X un total de x redes y x hosts en cada"
		elif [ $masc1 = "3" ]; then
			masc2="224.0.0.0"
			echo "$masc2 en clase X un total de x redes y x hosts en cada"
		elif [ $masc1 = "4" ]; then
			masc2="240.0.0.0"
			echo "$masc2 en clase X un total de x redes y x hosts en cada"
		elif [ $masc1 = "5" ]; then
			masc2="248.0.0.0"
			echo "$masc2 en clase X un total de x redes y x hosts en cada"
		elif [ $masc1 = "6" ]; then
			masc2="252.0.0.0"
			echo "$masc2 en clase X un total de x redes y x hosts en cada"
		elif [ $masc1 = "7" ]; then
			masc2="254.0.0.0"
			echo "$masc2 en clase X un total de x redes y x hosts en cada"
		elif [ $masc1 = "8" ]; then
			masc2="255.0.0.0"
			echo "$masc2 en clase A un total de 1 redes y 16777214 hosts en cada"
		elif [ $masc1 = "9" ]; then
			masc2="255.128.0.0"
			echo "$masc2 en clase A un total de 2 redes y 8388606 hosts en cada"
		elif [ $masc1 = "10" ]; then
			masc2="255.192.0.0"
			echo "$masc2 en clase A un total de 4 redes y 4194302 hosts en cada"
		elif [ $masc1 = "11" ]; then
			masc2="255.224.0.0"
			echo "$masc2 en clase A un total de 8 redes y 2097150 hosts en cada"
		elif [ $masc1 = "12" ]; then
			masc2="255.240.0.0"
			echo "$masc2 en clase A un total de 16 redes y 1048574 hosts en cada"
		elif [ $masc1 = "13" ]; then
			masc2="255.248.0.0"
			echo "$masc2 en clase A un total de 32 redes y 524286 hosts en cada"
		elif [ $masc1 = "14" ]; then
			masc2="255.252.0.0"
			echo "$masc2 en clase A un total de 64 redes y 262142 hosts en cada"
		elif [ $masc1 = "15" ]; then
			masc2="255.254.0.0"
			echo "$masc2 en clase A un total de 128 redes y 131070 hosts en cada"
		elif [ $masc1 = "16" ]; then
			masc2="255.255.0.0"
			echo "$masc2 en clase B un total de 1 redes y 65534 hosts en cada"
		elif [ $masc1 = "17" ]; then
			masc2="255.255.128.0"
			echo "$masc2 en clase B un total de 2 redes y 32766 hosts en cada"
		elif [ $masc1 = "18" ]; then
			masc2="255.255.192.0"
			echo "$masc2 en clase B un total de 4 redes y 16382 hosts en cada"
		elif [ $masc1 = "19" ]; then
			masc2="255.255.244.0"
			echo "$masc2 en clase B un total de 8 redes y 8190 hosts en cada"
		elif [ $masc1 = "20" ]; then
			masc2="255.255.240.0"
			echo "$masc2 en clase B un total de 16 redes y 4094 hosts en cada"
		elif [ $masc1 = "21" ]; then
			masc2="255.255.248.0"
			echo "$masc2 en clase B un total de 32 redes y 2046 hosts en cada"
		elif [ $masc1 = "22" ]; then
			masc2="255.255.252.0"
			echo "$masc2 en clase B un total de 64 redes y 1022 hosts en cada"
		elif [ $masc1 = "23" ]; then
			masc2="255.255.254.0"
			echo "$masc2 en clase B un total de 128 redes y 510 hosts en cada"
		elif [ $masc1 = "24" ]; then
			masc2="255.255.255.0"
			echo "$masc2 en clase C un total de 1 redes y 254 hosts en cada"
		elif [ $masc1 = "25" ]; then
			masc2="255.255.255.168"
			echo "$masc2 en clase C un total de 2 redes y 126 hosts en cada"
		elif [ $masc1 = "26" ]; then
			masc2="255.255.255.192"
			echo "$masc2 en clase C un total de 4 redes y 62 hosts en cada"
		elif [ $masc1 = "27" ]; then
			masc2="255.255.255.224"
			echo "$masc2 en clase C un total de 8 redes y 30 hosts en cada"
		elif [ $masc1 = "28" ]; then
			masc2="255.255.255.240"
			echo "$masc2 en clase C un total de 16 redes y 14 hosts en cada"
		elif [ $masc1 = "29" ]; then
			masc2="255.255.255.248"
			echo "$masc2 en clase C un total de 32 redes y 6 hosts en cada"
		elif [ $masc1 = "30" ]; then
			masc2="255.255.255.252"
			echo "$masc2 en clase C un total de 64 redes y 2 hosts en cada"
		elif [ $masc1 = "31" ]; then
			masc2="255.255.255.254"
			echo "$masc2 en clase C un total de 128 redes y 1 hosts en cada"
		elif [ $masc1 = "32" ]; then
			masc2="255.255.255.255"
			echo "$masc2 es un broadcast"
		fi
		printf "netmask $masc2\n">>/etc/network/interfaces
		printf "¿Especificara gateway? (si,no):\n"
		read elec0
		if [ $elec0 = "si" ]; then
			printf "Especifique gateway ejem: 192.168.20.1 (entera)\n"
			read gateinter0
			printf "gateway $gateinter0\n">>/etc/network/interfaces
		elif [ $elec0 = "no" ]; then
			printf "No se especificara ninguna gateway\n"
		fi
		printf "Realizado correctamente\n"
		cat "/etc/network/interfaces"
		printf "OK\n">>$pathLog
	fi
	let contador=$contador+1
done
echo "Volviendo al menu en:"
echo "		3"
sleep 1
echo "		2"
sleep 1
echo "		1"
sleep 1