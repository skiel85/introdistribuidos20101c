#! /bin/ksh

############################
#CONFIGURACION DEL SERVIDOR#
############################

# Parametro 1 = interface fisica
# Parametro 2 = nombre del servidor

# Clear de interfaces
ifconfig $1 down

# Clear de tabla de ruteo
./clearRoutes.ksh

if [ $2 == "webserver" ];then	
	ifconfig $1:1 192.168.23.1 netmask 255.255.255.255
	route add -net 192.168.23.0 netmask 255.255.255.0 $1:1

elif [ $2 == "telserver" ];then
	ifconfig $1:1 10.38.1.130 netmask 255.255.255.255
	ifconfig $1:2 10.38.23.129 netmask 255.255.255.255
	route add -net 10.38.1.128 netmask 255.255.255.128 $1:1
	route add -net 10.38.23.128 netmask 255.255.255.240 $1:2

elif [ $2 == "ftpserver" ];then
	ifconfig $1:1 10.7.1.1 netmask 255.255.255.255
	route add -net 10.7.1.0 netmask 255.255.255.0 $1:1
else
	echo "Indicar nombre de servidor como parametro"
fi
