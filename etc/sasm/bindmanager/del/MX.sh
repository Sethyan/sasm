#!/bin/bash
pathLog="/var/log/ssm.log"
echo "No esta operativo aún"
sleep 1
exec ./menu.sh
#echo "Seleccione el nombre de la zona directa con la que va a trabajar:"
#ls /etc/bind/ | grep *.hosts
#read directa