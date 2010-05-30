#! /bin/ksh

########################
#CONFIGURACION DEL HOST#
########################

# Parametro 1 = interface fisica
# Parametro 2 = nombre del servidor

# Clear de interfaces
ifconfig $1 down

# Clear de tabla de ruteo
./clearRoutes.ksh

if [ $2 -eq 1 ];then
	# Configuro IP de HOST 1
elif [ $2 -eq 2 ];then
	# Configuro IP de HOST 2
elif [ $2 -eq 3 ];then
	ifconfig $1:1 10.38.23.133 netmask 255.255.255.255
	route add -net 10.38.23.128 netmask 255.255.255.240 $1:1
else
	echo "Indicar # de host como parametro"
fi

