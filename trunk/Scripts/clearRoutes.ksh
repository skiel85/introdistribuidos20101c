#! /bin/ksh

####################
# BORRADO DE RUTAS #
####################

# Archivo para guardar la tabla actual de ruteo
touch table.temp
chmod 777 table.temp

# Tabla actual de ruteo
netstat -rn | grep "^[0-9].*" > table.temp
cat table.temp | while read LINE;do
	IP=`echo $LINE | awk '{print $1}'`
	MASCARA=`echo $LINE | awk '{print $3}'`
	route del -net $IP netmask $MASCARA
done
