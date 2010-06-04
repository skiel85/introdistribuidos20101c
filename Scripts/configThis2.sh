#! /bin/ksh

######################################
# Script de configuracion de equipos #
#             Grupo 1                #
######################################

# LISTADO DE PARAMETROS
# ROUTERS
# h1, h2 , h3, h4, h7, h11, h13, h15, h16, h29, h30, h31, h34

# SERVIDORES
# webserver, telserver_j, telserver_n, ftpserver

# HOSTS
# hostA, hostB, hostC

# FUNCION PARA LIMPIAR LA TABLA DE RUTEO
clearRoutes() {
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
}

# REDES A CONFIGURAR
NET_A_1=10.5.1.64
MSK_A_1=255.255.255.248

NET_A_2=10.5.1.68
MSK_A_2=255.255.255.248

NET_A_3=10.5.1.72
MSK_A_3=255.255.255.248

NET_A_4=10.5.1.76
MSK_A_4=255.255.255.248

NET_A_5=10.5.1.80
MSK_A_5=255.255.255.248

NET_A_6=10.5.1.84
MSK_A_6=255.255.255.248

NET_B=10.38.23.0
MSK_B=255.255.255.192

NET_C=10.38.23.252
MSK_C=255.255.255.252

NET_D=10.38.23.144
MSK_D=255.255.255.240

NET_E=192.168.23.0
MSK_E=255.255.255.0

NET_F=157.43.1.248
MSK_F=255.255.255.252

NET_G=157.43.1.252
MSK_G=255.255.255.252

NET_H=10.38.23.96
MSK_H=255.255.255.224

NET_I=10.38.23.248
MSK_I=255.255.255.252

NET_J=10.38.23.128
MSK_J=255.255.255.128

NET_K=10.38.23.64
MSK_K=255.255.255.224

NET_L=10.38.1.0
MSK_L=255.255.255.128

NET_M=10.7.1.0
MSK_M=255.255.255.0

NET_N=10.38.1.128
MSK_N=255.255.255.128

# IP DE LOS ROUTERS

##########################
# X.25
  H1_A1=10.5.1.65
  H1_A2=10.5.1.69
  H1_A3=10.5.1.73
  
H1_B=10.38.23.1
##########################

##########################
H2_B=10.38.23.2
H2_C=10.38.23.253
##########################

##########################
H3_B=10.38.23.3
H3_D=10.38.23.145
H3_E=192.168.23.2
##########################

##########################
H4_B=10.38.23.4
H4_E=192.168.23.3
##########################

##########################
H7_E=192.168.23.4
##########################

##########################
# X.25
  H11_A1=10.5.1.66
  H11_A4=10.5.1.77
  H11_A5=10.5.1.81
  	
H11_L=10.38.1.1
##########################

##########################
H13_C=10.38.23.254
H13_J=10.38.23.130
H13_L=10.38.1.2
H13_N=10.38.1.129
##########################

##########################
# X.25
  H15_A2=10.5.1.70
  H15_A4=10.5.1.78
  H15_A6=10.5.1.85
	
H15_I=10.38.23.249	
H15_J=10.38.23.131
H15_L=10.38.1.3
##########################

##########################
H16_J=10.38.23.132
##########################

##########################
H29_K=10.38.23.65
H29_M=10.7.1.2
##########################

##########################
# X.25
  H30_A3=10.5.1.74
  H30_A5=10.5.1.82
  H30_A6=10.5.1.86
	
H30_K=10.38.23.66
##########################

##########################
H31_H=10.38.23.97
H31_K=10.38.23.67
H31_M=10.7.1.3
##########################

##########################
H34_H=10.38.23.98
H34_I=10.38.23.250	
##########################

# HOSTS
HOSTA_NETB=10.38.23.5
HOSTB_NETK=10.38.23.68
HOSTC_NETJ=10.38.23.133

# SERVIDORES
WEB_SERVER=192.168.23.1
TEL_SERVER_J=10.38.23.129
TEL_SERVER_N=10.38.1.130
FTP_SERVER=10.7.1.1

# CONFIGURO LOS DNS
MASTER_DNS=0.0.0.0
SLAVE_DNS=0.0.0.0
echo "nameserver $MASTER_DNS\nnameserver $SLAVE_DNS" > /etc/resolv.conf

# SHUTEO TODAS LAS INTERFACES ETHERNET QUE HAYA
ifconfig | grep "^eth.*" | awk {'print $1'} | while read LINE
do
	ifconfig $LINE down
done

# RECUPERO EL NOMBRE DE LA PRIMERA INTERFACE ETHERNET
# QUE ES LA QUE VOY A USAR
ETH=`ifconfig | grep -m1 "^eth.*" | awk {'print $1'} | while read LINE`
# LEVANTO LA INTERFACE
ifconfig $ETH up

# FORWARDING
echo 1 > /proc/sys/net/ipv4/ip_forward

case "$1" in
            h1)
                ifconfig $ETH $H1_A1 netmask $MSK_A_1
                ifconfig $ETH:0 $H1_A2 netmask $MSK_A_2
                ifconfig $ETH:1 $H1_A3 netmask $MSK_A_3
                ifconfig $ETH:2 $H1_B netmask $MSK_B               
                
                # ACA VAN LAS RUTAS                                    
            ;;
            h2)
                ifconfig $ETH $H2_B netmask $MSK_B
                ifconfig $ETH $H2_C netmask $MSK_C
                
                #ACA VAN LAS RUTAS
            ;;
            h3)
            ;;
            h4)
            ;;
            h7)
            ;;
            h11)
            ;;
            h13)
            ;;
            h15)
            ;;
            h16)
            ;;
            h29)
            ;;
            h30)
            ;;
            h31)
            ;;
            h34)
            ;;
            webserver)
            ;;
            telserver_j)
            ;;
            telserver_n)
            ;;
            ftpserver)
            ;;
            hostA)
            ;;
            hostB)
            ;;
            hostC)
            ;;
esac




