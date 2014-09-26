#!/bin/bash
#
# A programar en Español como Carlos Alonso xD
#
# Creación del servidor primario
#
clear
pathLog="/var/log/ssm.log"
printf "¿Quiere reiniciar la configuración del archivo named.conf.local? (si/no)\n"
read named
if [ $named = si ]; then
	true > /etc/bind/named.conf.\local
elif [ $named = !si ]; then
	echo "no se reinicia nada"
fi
printf "¿Cuantas zonas directas quiere crear?\n"
contador="1"
read zonas
while [ $contador -le $zonas ]; do
	printf "Creando Zona directa\n"
	date>>$pathLog
	printf "Creando Zona directa\n">>$pathLog
	printf "Ponga aqui la primera parte del nombre del dominio, ejem: 'sethyan' de setyan.com:\n"
	printf "Op:\n"
	read domi
	printf "Ponga aqui la segunda parte del nombre del domino, ejem: 'com' 'es' ' org'\n"
	printf "Op:\n"
	read nio
	date>>$pathLog
	printf "elegido dominio $domi.$nio\n">>$pathLog
	printf "ha elegido $domi.$nio "
	printf "Elige la clase de la ip, ejem: 'A' ' B' 'C'\n"
	printf "Op:\n"
	read clase
	if [ $clase = "A" ]; then
		date>>$pathLog
		printf "eligiendo clase de ip\n">>$pathLog
		printf "Ha elegido clase A, diga el numero de red 192.168.().X\n"
		printf "op:\n"
		read red1
		printf "Ahora eliga la ip que utilizara su servidor 192.168.$red1.()\n"
		printf "op:\n"
		read ip1
	elif [ $clase = "B" ]; then
		date>>$pathLog
		printf "eligiendo clase de ip\n">>$pathLog
		printf "Ha elegido clase B, diga el numero de red 172.().X.X '16/31'\n"
		printf "op:\n"
		read red2
		printf "Ahora eliga la primera ip que utilizara su servidor 172.$red2.().X '0/254'\n"
		printf "op:\n"
		read red1
		printf "Ahora eliga la segunda ip que utilizara su servidor 172.$red2.$red1.() '0/254'\n"
		printf "op:\n"
		read ip1
		date>>$pathLog
		printf "$domi.$nio 172.red2.$red1.$ip1 $masc2\n">>$pathLog
		true > /etc/bind/etc/bind/db.$domi.hosts
		true > /etc/bind/172.$red2.$red1.rev
		/bin/cp /etc/ssm/files/directa /etc/bind/db.$domi.hosts
		/bin/chown root:root /etc/bind/db.$domi.hosts
		/bin/chown root:root /etc/bind/172.$red2.$red1.rev
		rndc querylog
		touch /etc/ssm/info/domino$contador
		touch /etc/ssm/info/dominame$contador
		touch /etc/ssm/info/indirecto$contador
		printf "nameserver 127.0.0.1\n">>/etc/resolvconf/resolv.conf.d/base
		printf "$domi.$nio\n">>/etc/ssm/info/dominio$contador
		printf "$domi\n">>/etc/ssm/info/dominame$contador
		printf "$red2\n">>/etc/ssm/info/indirecto$contador
		echo "zone \"$domi.$nio\" {">>/etc/bind/named.conf.\local
		echo "	type master;">>/etc/bind/named.conf.\local
		echo "	file \"/etc/bind/db.$domi.hosts\";">>/etc/bind/named.conf.\local
		echo "	notify yes;">>/etc/bind/named.conf.\local
		echo "};">>/etc/bind/named.conf.\local
		printf "Configurado named.conf.local\n"
		printf "¿Que nombre utilizara para su servidor DNS?\n"
		read servdns
		echo "\$TTL	604800">>/etc/bind/db.$domi.hosts
		echo "@	IN	SOA	$servdns.$domi.$nio.	root.$domi.$nio.	(">>/etc/bind/db.$domi.hosts
		echo "				1		; Serial">>/etc/bind/db.$domi.hosts
		echo "				604800		; Refresh">>/etc/bind/db.$domi.hosts
		echo "				86400		; Retry">>/etc/bind/db.$domi.hosts
		echo "				2419200		; Expire">>/etc/bind/db.$domi.hosts
		echo "				604800 )	; Negative Cache TTL">>/etc/bind/db.$domi.hosts
		echo "@			IN		NS		$servdns">>/etc/bind/db.$domi.hosts
		echo "@			IN		A		172.$red2.$red1.$ip1">>/etc/bind/db.$domi.hosts
		echo "$servdns		IN		A		172.$red2.$red1.$ip1">>/etc/bind/db.$domi.hosts
		printf "Configurado db.$domi.hosts\n"
		printf "¿Quiere configurar zona inversa? (si/no) !!!No funcional en clase B\n"
		read eleccion
		if [ $eleccion = si ]; then
			/bin/cp /etc/ssm/files/indirecta /etc/bind/192.168.$red1.rev
			echo "zone \"$red1.168.192.in-addr.arpa\" {">>/etc/bind/named.conf.\local
			echo "	type master;">>/etc/bind/named.conf.\local
			echo "	file \"/etc/bind/192.168.$red1.rev\";">>/etc/bind/named.conf.\local
			echo "	notify yes;">>/etc/bind/named.conf.\local
			echo "};">>/etc/bind/named.conf.\local
			echo "\$TTL	604800">>/etc/bind/192.168.$red1.rev
			echo "@	IN	SOA	$servdns.$domi.$nio.	root.$domi.$nio.	(">>/etc/bind/192.168.$red1.rev
			echo "				1		; Serial">>/etc/bind/192.168.$red1.rev
			echo "				604800		; Refresh">>/etc/bind/192.168.$red1.rev
			echo "				86400		; Retry">>/etc/bind/192.168.$red1.rev
			echo "				2419200		; Expire">>/etc/bind/192.168.$red1.rev
			echo "				604800 )	; Negative Cache TTL">>/etc/bind/192.168.$red1.rev
			echo "@					IN		NS		$servdns.$domi.$nio.">>/etc/bind/192.168.$red1.rev
			echo "$ip1.$red1.168.192.in-addr.arpa.	IN		PTR		$domi.$nio.">>/etc/bind/192.168.$red1.rev
			echo "$ip1.$red1.168.192.in-addr.arpa.	IN		PTR		$servdns.$domi.$nio.">>/etc/bind/192.168.$red1.rev
			printf "Configurado 192.168.$red1.rev\n"
			printf "Configurando el resolv.conf\n"
			printf "search $domi.$nio\n">>/etc/resolvconf/resolv.conf.d/base
			printf "Reiniciando la red\n"
			/etc/init.d/networking restart
			printf "Reiniciando el servicio DNS\n"
			/etc/init.d/bind9 restart
			printf "Comprovación de las zonas\n"
			named-checkconf -z
			sleep 1
			printf "Segunda comprovación de las zonas\n"
			named-checkzone -D $domi.$nio /etc/bind/db.$domi.hosts
			sleep 1
			printf "Tercera comprovación de las zonas\n"
			named-checkzone -D $red1.168.192.\in-addr.arpa /etc/bind/192.168.$red1.rev
			sleep 1
			printf "Comprovación del funcionamiento del dominio\n"
			nslookup $domi.$nio
			sleep 1
			printf "Segunda comprovación del funcionamiento del dominio\n"
			dig $domi.$nio
			sleep 1
			printf "Tercera comprovación de las zonas\n"
			dig $red1.168.192.\in-addr.arpa
			sleep 1
		elif [ $eleccion = no ]; then
			printf "Configurando el resolv.conf\n"
			echo "search $domi.$nio">>/etc/resolvconf/resolv.conf.d/base
			printf "Reiniciando la red\n"
			/etc/init.d/networking restart
			printf "Reiniciando el servicio DNS\n"
			/etc/init.d/bind9 restart
			printf "Comprovación de las zonas\n"
			named-checkconf -z
			sleep 1
			printf "Segunda comprovación de las zonas\n"
			named-checkzone -D $domi.$nio /etc/bind/db.$domi.hosts
			sleep 1
			printf "Comprovación del funcionamiento del dominio\n"
			nslookup $domi.$nio
			sleep 1
			printf "Segunda comprovación del funcionamiento del dominio\n"
			dig $domi.$nio
			sleep 1
		fi
	elif [ $clase = "C" ]; then
		date>>$pathLog
		printf "eligiendo clase de ip\n">>$pathLog
		printf "Ha elegido clase C, diga el numero de red 192.168.().X '0/255'\n"
		printf "op:\n"
		read red1
		printf "Ahora eliga la ip que utilizara su servidor 192.168.$red1.()\n"
		printf "op:\n"
		read ip1
		date>>$pathLog
		printf "$domi.$nio 192.168.$red1.$ip1 $masc2\n">>$pathLog
		/bin/rm /etc/bind/etc/bind/db.$domi.hosts
		/bin/rm /etc/bind/192.168.$red1.rev
		/bin/cp /etc/ssm/files/directa /etc/bind/db.$domi.hosts
		/bin/chown root:root /etc/bind/db.$domi.hosts
		/bin/chown root:root /etc/bind/192.168.$red1.rev
		rndc querylog
		touch /etc/ssm/info/domino$contador
		touch /etc/ssm/info/dominame$contador
		touch /etc/ssm/info/indirecto$contador
		printf "nameserver 127.0.0.1\n">>/etc/resolvconf/resolv.conf.d/base
		printf "$domi.$nio\n">>/etc/ssm/info/dominio$contador
		printf "$domi\n">>/etc/ssm/info/dominame$contador
		printf "$red1\n">>/etc/ssm/info/indirecto$contador
		echo "zone \"$domi.$nio\" {">>/etc/bind/named.conf.\local
		echo "	type master;">>/etc/bind/named.conf.\local
		echo "	file \"/etc/bind/db.$domi.hosts\";">>/etc/bind/named.conf.\local
		echo "	notify yes;">>/etc/bind/named.conf.\local
		echo "};">>/etc/bind/named.conf.\local
		printf "Configurado named.conf.local\n"
		printf "¿Que nombre utilizara para su servidor DNS?\n"
		read servdns
		echo "\$TTL	604800">>/etc/bind/db.$domi.hosts
		echo "@	IN	SOA	$servdns.$domi.$nio.	root.$domi.$nio.	(">>/etc/bind/db.$domi.hosts
		echo "				1		; Serial">>/etc/bind/db.$domi.hosts
		echo "				604800		; Refresh">>/etc/bind/db.$domi.hosts
		echo "				86400		; Retry">>/etc/bind/db.$domi.hosts
		echo "				2419200		; Expire">>/etc/bind/db.$domi.hosts
		echo "				604800 )	; Negative Cache TTL">>/etc/bind/db.$domi.hosts
		echo "@			IN		NS		$servdns">>/etc/bind/db.$domi.hosts
		echo "@			IN		A		192.168.$red1.$ip1">>/etc/bind/db.$domi.hosts
		echo "$servdns		IN		A		192.168.$red1.$ip1">>/etc/bind/db.$domi.hosts
		printf "Configurado db.$domi.hosts\n"
		printf "¿Quiere configurar zona inversa? (si/no)\n"
		read eleccion
		if [ $eleccion = si ]; then
			/bin/cp /etc/ssm/files/indirecta /etc/bind/192.168.$red1.rev
			echo "zone \"$red1.168.192.in-addr.arpa\" {">>/etc/bind/named.conf.\local
			echo "	type master;">>/etc/bind/named.conf.\local
			echo "	file \"/etc/bind/192.168.$red1.rev\";">>/etc/bind/named.conf.\local
			echo "	notify yes;">>/etc/bind/named.conf.\local
			echo "};">>/etc/bind/named.conf.\local
			echo "\$TTL	604800">>/etc/bind/192.168.$red1.rev
			echo "@	IN	SOA	$servdns.$domi.$nio.	root.$domi.$nio.	(">>/etc/bind/192.168.$red1.rev
			echo "				1		; Serial">>/etc/bind/192.168.$red1.rev
			echo "				604800		; Refresh">>/etc/bind/192.168.$red1.rev
			echo "				86400		; Retry">>/etc/bind/192.168.$red1.rev
			echo "				2419200		; Expire">>/etc/bind/192.168.$red1.rev
			echo "				604800 )	; Negative Cache TTL">>/etc/bind/192.168.$red1.rev
			echo "@					IN		NS		$servdns.$domi.$nio.">>/etc/bind/192.168.$red1.rev
			echo "$ip1.$red1.168.192.in-addr.arpa.	IN		PTR		$domi.$nio.">>/etc/bind/192.168.$red1.rev
			echo "$ip1.$red1.168.192.in-addr.arpa.	IN		PTR		$servdns.$domi.$nio.">>/etc/bind/192.168.$red1.rev
			printf "Configurado 192.168.$red1.rev\n"
			printf "Configurando el resolv.conf\n"
			printf "search $domi.$nio\n">>/etc/resolvconf/resolv.conf.d/base
			printf "Reiniciando la red\n"
			/etc/init.d/networking restart
			printf "Reiniciando el servicio DNS\n"
			/etc/init.d/bind9 restart
			printf "Comprovación de las zonas\n"
			named-checkconf -z
			sleep 1
			printf "Segunda comprovación de las zonas\n"
			named-checkzone -D $domi.$nio /etc/bind/db.$domi.hosts
			sleep 1
			printf "Tercera comprovación de las zonas\n"
			named-checkzone -D $red1.168.192.\in-addr.arpa /etc/bind/192.168.$red1.rev
			sleep 1
			printf "Comprovación del funcionamiento del dominio\n"
			nslookup $domi.$nio
			sleep 1
			printf "Segunda comprovación del funcionamiento del dominio\n"
			dig $domi.$nio
			sleep 1
			printf "Tercera comprovación de las zonas\n"
			dig $red1.168.192.\in-addr.arpa
			sleep 1
		elif [ $eleccion = no ]; then
			printf "Configurando el resolv.conf\n"
			echo "search $domi.$nio">>/etc/resolvconf/resolv.conf.d/base
			printf "Reiniciando la red\n"
			/etc/init.d/networking restart
			printf "Reiniciando el servicio DNS\n"
			/etc/init.d/bind9 restart
			printf "Comprovación de las zonas\n"
			named-checkconf -z
			sleep 1
			printf "Segunda comprovación de las zonas\n"
			named-checkzone -D $domi.$nio /etc/bind/db.$domi.hosts
			sleep 1
			printf "Comprovación del funcionamiento del dominio\n"
			nslookup $domi.$nio
			sleep 1
			printf "Segunda comprovación del funcionamiento del dominio\n"
			dig $domi.$nio
			sleep 1
		fi
	fi
	let contador=$contador+1
done
echo "Pulse intro para continuar"
read nada
exec /etc/ssm/bindmanager/menu.sh