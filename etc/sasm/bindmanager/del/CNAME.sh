#!/bin/bash
pathLog="/var/log/ssm.log"
clear
echo "Seleccione el nombre de la zona directa con la que va a trabajar: (entero)"
ls /etc/bind/ | grep *.hosts
read directa
echo "Seleccione el nombre que pondra al registro:"
echo "()	IN	CNAME	(X)"
read nombre
echo "$nombre(dominio)	IN	CNAME	(X)"
echo "¿Quiere quitar el dominio despues del nombre? 'si/no'"
read quitar
if [ $quitar = si ]; then
	nombre=$nombre.
	echo "$nombre	IN	CNAME	()"
elif [ $quitar = no ]; then
	echo "No se hará nada"
	echo "$nombre	IN	CNAME	()"
fi
echo "Seleccione el nombre que sustituira en el registro:"
read sustituir
echo "$nombre	IN	CNAME	$sustituir"
echo "Añadiendo registro a la zona"
echo "CNAME>SOA">>$pathLog
echo "$nombre	IN	CNAME	$sustituir">>/etc/bind/$directa
exec ./menu.sh