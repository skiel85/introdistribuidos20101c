#!/bin/bash

######################################
# Script de configuracion de DNS     #
#	      Grupo 1		                   #
######################################

# LISTADO DE CONSTANTES
ROOT="root"
SLAVE="slave"
CONCARAN="concaran"
RESTO="resto"

H2_B=10.38.23.2
SLAVE_NETB=10.38.23.6
MSK_B=255.255.255.192

H13_J=10.38.23.130
CONCARAN_NETJ=10.38.23.134
MSK_J=255.255.255.240

H31_K=10.4.3.35
RESTO_NETK=10.4.3.37
MSK_K=255.255.255.224

H13_N=10.38.1.129
ROOT_NETN=10.38.1.131
MSK_N=255.255.255.128

BIND_DIR="/etc/bind"
ROOT_DIR="root"
SLAVE_DIR="slave"
CONCARAN_DIR="concaran"
RESTO_DIR="resto"

# LISTADO DE PARAMETROS
# root, slave, concaran, quines

# SHUTEO TODAS LAS INTERFACES ETHERNET QUE HAYA
ifconfig | grep "^eth.*" | awk {'print $1'} | while read LINE
do
	ifconfig $LINE down
done

# RECUPERO EL NOMBRE DE LA PRIMERA INTERFACE ETHERNET
# QUE ES LA QUE VOY A USAR
ETH=`ifconfig -a | grep -m1 "^eth.*" | awk {'print $1'}`

# LEVANTO LA INTERFACE
ifconfig $ETH up
sleep 20

case "$1" in
	    $ROOT)
        	# CONFIGURACION DE RED Y DEFAULT GATEWAY PARA ROOT
        	ifconfig $ETH $ROOT_NETN netmask $MSK_N
        	route add -net default gw $H13_N
        	# ARCHVOS DE DNS
        	cp $BIND_DIR/named.conf.local $BIND_DIR/named.conf.local.bk.g1
        	cp $ROOT_DIR/named.conf $BIND_DIR/named.conf.local
        	cp $ROOT_DIR/db.sanluis $BIND_DIR/db.sanluis
		cp $ROOT_DIR/db.reversos $BIND_DIR/db.reversos
	    ;;
	    $SLAVE)
	      	# CONFIGURACION DE RED Y DEFAULT GATEWAY PARA SLAVE
        	ifconfig $ETH $SLAVE_NETB netmask $MSK_B
        	route add -net default gw $H2_B
        	# ARCHVOS DE DNS
        	cp $BIND_DIR/named.conf $BIND_DIR/named.conf.local.bk.g1
        	cp $SLAVE_DIR/named.conf $BIND_DIR/named.conf.local
		cp $SLAVE_DIR/db.reversos $BIND_DIR/db.reversos
		cp $SLAVE_DIR/db.sanluis $BIND_DIR/db.sanluis
	    ;;
	    $CONCARAN)
        	ifconfig $ETH $CONCARAN_NETJ netmask $MSK_J
        	route add -net default gw $H13_J
        	# ARCHVOS DE DNS
        	cp $BIND_DIR/named.conf.local $BIND_DIR/named.conf.local.bk.g1
        	cp $CONCARAN_DIR/named.conf $BIND_DIR/named.conf.local
        	cp $CONCARAN_DIR/db.concaran $BIND_DIR/db.concaran
        	cp $CONCARAN_DIR/db.1-7-10 $BIND_DIR/db.1-7-10
        	cp $CONCARAN_DIR/db.3-4-10 $BIND_DIR/db.3-4-10
	    ;;
	    $RESTO)
        	ifconfig $ETH $RESTO_NETK netmask $MSK_K
        	route add -net default gw $H31_K
        	# ARCHVOS DE DNS
        	cp $BIND_DIR/named.conf $BIND_DIR/named.conf.bk.g1        	
        	cp $RESTO_DIR/merlo.db $BIND_DIR/merlo.db
        	cp $RESTO_DIR/quines.db $BIND_DIR/quines.db
        	cp $RESTO_DIR/db.1-5-10 $BIND_DIR/db.1-5-10
        	cp $RESTO_DIR/db.1-38-10 $BIND_DIR/db.1-38-10
        	cp $RESTO_DIR/db.1-43-157 $BIND_DIR/db.1-43-157
        	cp $RESTO_DIR/db.23-38-10 $BIND_DIR/db.23-38-10
	    ;;
	    *)
        	echo "Parametro incorrecto."
      ;;
esac

# DETENEMOS E INICIAMOS EL SERVICIO DE DNS (BIND)
/etc/init.d/bind9 stop
/etc/init.d/bind9 start