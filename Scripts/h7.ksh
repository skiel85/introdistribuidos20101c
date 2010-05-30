#! /bin/ksh

#############################
#CONFIGURACION DEL ROUTER H7#
#############################

# Parametro 1 = interface fisica

# Clear de interfaces
ifconfig $1 down

# Clear de tabla de ruteo
./clearRoutes.ksh

# Configuracion de interfaces
	# RED E
	ifconfig $1:1 up
	ifconfig $1:1 192.168.23.4 netmask 255.255.255.0
	route add -net 192.168.23.0 netmask 255.255.255.0 $1:1
	
	# RED F
	ifconfig $1:2 up
	ifconfig $1:2 157.143.1.5 netmask 255.255.255.252
	route add -net 157.143.1.4 netmask 255.255.255.252 $1:2

# Configuracion de rutas principales
	# RED E
	
	# Salida Internet (RED F)	
	route add -net 0.0.0.0 netmask 0.0.0.0 gw 157.143.1.6	

# Configuracion de rutas de contingencia
