#!/bin/bash
pathLog="/var/log/ssm.log"
clear
echo "Seleccione el nombre de la zona directa con la que va a trabajar: (entero)"
ls /etc/bind/ | grep *.hosts
read directa
echo "Seleccione el nombre del servidor DNS sin dominio:"
echo "@	IN	NS	()"
read nombre
echo "@	IN	NS	$nombre"
echo "¿Complementara con una zona inversa? 'si/no'"
read resp
if [ $resp = "si" ]; then
	echo "Seleccione el nombre de la zona inversa con la que va a trabajar: (entero)"
	ls /etc/bind/ | grep *.rev
	read inversa
	echo "Seleccione que ip, por partes, que pondra al servidor DNS: '().X.X.X'(solo numeros)"
	read ip1
	echo "Seleccione que ip, por partes, que pondra al servidor DNS: '$ip1.().X.X'(solo numeros)"
	read ip2
	echo "Seleccione que ip, por partes, que pondra al servidor DNS: '$ip1.ip2.().X'(solo numeros)"
	read ip3
	echo "Seleccione que ip, por partes, que pondra al servidor DNS: '$ip1.ip2.ip3.()'(solo numeros)"
	read ip4
	echo "@	IN	NS	$nombre"
	echo "@	IN	A	$ip1.$ip2.$ip3.ip4"
	echo "$nombre	IN	A	$ip1.$ip2.$ip3.ip4"
	echo "Añadiendo registro a la zona"
	echo "NS>SOA">>$pathLog
	echo "@	IN	NS	$nombre">>/etc/bind/$directa
	echo "@	IN	A	$ip1.$ip2.$ip3.ip4">>/etc/bind/$directa
	echo "$nombre	IN	A	$ip1.$ip2.$ip3.ip4">>/etc/bind/$directa
	echo "Especifique manualmente el dominio con el que se esta trabajando: 'ejemplo: sethyan.org'"
	read dominio
	echo "@	IN	PTR	$nombre.$dominio"
	echo "$ip4	IN	PTR	$dominio"
	echo "$ip4	IN	PTR	$nombre.$dominio"
	echo "Añadiendo registro a la zona"
	echo "NS>SOA">>$pathLog
	echo "@	IN	PTR	$nombre.$dominio">>/etc/bind/$inversa	
	echo "$ip4	IN	PTR	$dominio">>/etc/bind/$inversa
	echo "$ip4	IN	PTR	$nombre.$dominio">>/etc/bind/$inversa
else [ $resp = "no" ]; then
	echo "Seleccione que ip que pondra al registro: (entera)"
	read ip
	echo "@	IN	NS	$nombre"
	echo "@	IN	A	$ip"
	echo "$nombre	IN	A	$ip"
	echo "Añadiendo registro a la zona"
	echo "A>SOA">>$pathLog
	echo "@	IN	NS	$nombre">>/etc/bind/$directa
	echo "@	IN	A	$ip">>/etc/bind/$directa
	echo "$nombre	IN	A	$ip">>/etc/bind/$directa
fi
exec ./menu.sh