#! /bin/sh

######################################
# Script de configuracion de DNS     #
#	      Grupo 1		                   #
######################################

# LISTADO DE CONSTANTES
ROOT="root"
SLAVE="slave"
CONCARAN="concaran"
QUINES="quines"

H13_L=10.38.1.2
ROOT_NETL=10.38.1.31
MSK_L=255.255.255.128

H2_B=10.38.23.2
SLAVE_NETB=10.38.23.5
MSK_B=255.255.255.192

H31_K=10.38.23.67
CONCARAN_NETK=10.38.23.68
MSK_K=255.255.255.224

H13_J=10.38.23.130
RESTO_NETJ=10.38.23.133
MSK_J=255.255.255.240

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
ETH=`ifconfig -a | grep -m1 "^eth.*" | awk {'print $1'} | while read LINE`

# LEVANTO LA INTERFACE
ifconfig $ETH up
sleep 20

case "$1" in
	    $ROOT)
        # CONFIGURACION DE RED Y DEFAULT GATEWAY PARA ROOT
        ifconfig $ETH $ROOT_NETL netmask $MSK_L
        route add default gw $H13_L
        # ARCHVIOS DE DNS
        cp $BIND_DIR/named.conf $BIND_DIR/named.conf.bk.g1
        cp $ROOT_DIR/named.conf $BIND_DIR/named.conf
        cp $ROOT_DIR/sanluis.db $BIND_DIR/sanluis.db
        cp $ROOT_DIR/rev.db $BIND_DIR/rev.db
	    ;;
	    $SLAVE)
	      # CONFIGURACION DE RED Y DEFAULT GATEWAY PARA SLAVE
        ifconfig $ETH $SLAVE_NETB netmask $MSK_B
        route add default gw $H2_B
        # ARCHVIOS DE DNS
        cp $BIND_DIR/named.conf $BIND_DIR/named.conf.bk.g1
        cp $SLAVE_DIR/named.conf $BIND_DIR/named.conf
	    ;;
	    $CONCARAN)
        ifconfig $ETH $CONCARAN_NETK netmask $MSK_K
        route add default gw $H31_K
        # ARCHVIOS DE DNS
        cp $BIND_DIR/named.conf $BIND_DIR/named.conf.bk.g1
        cp $CONCARAN_DIR/named.conf $BIND_DIR/named.conf
        cp $CONCARAN_DIR/concaran.db $BIND_DIR/concaran.db
        cp $CONCARAN_DIR/k.db $BIND_DIR/k.db
        cp $CONCARAN_DIR/m.db $BIND_DIR/m.db
	    ;;
	    $QUINES)
        ifconfig $ETH $RESTO_NETJ netmask $MSK_J
        route add default gw $H13_J
        # ARCHVIOS DE DNS
        cp $BIND_DIR/named.conf $BIND_DIR/named.conf.bk.g1
        cp $BIND_DIR/named.conf $BIND_DIR/named.conf
        cp $RESTO_DIR/merlo.db $BIND_DIR/merlo.db
        cp $RESTO_DIR/quines.db $BIND_DIR/quines.db
        cp $RESTO_DIR/b.db $BIND_DIR/b.db
        cp $RESTO_DIR/e.db $BIND_DIR/e.db
        cp $RESTO_DIR/j.db $BIND_DIR/j.db
        cp $RESTO_DIR/n.db $BIND_DIR/n.db
	    ;;
	    *)
        echo "Parametro incorrecto."
      ;;
esac

# DETENEMOS E INICIAMOS EL SERVICIO DE DNS (BIND)
/etc/init.d/bind9 stop
/etc/init.d/bind9 start