#!/bin/bash
# Date Creation: 28/12/2020
# Server Enviroment: Debian GNU LINUX 9.0 or higher | UBUNTU 16.04 or higher
# Copyright: Octávio Filipe Gonçalves AKA Subv3rsion
# Last Modified: Octávio Filipe Gonçalves AKA Subv3rsion
# Last Modified Date: 28/12/2020
###
# Check if VPN is running, and restablish VPN Connection if link is down
# This script works with VPN type PPTP and OpenVPN
#

# VPN type (pptp or openvpn)
VPN_TYPE="";

# If the VPN is PPTP type, define the peers config file located under /etc/ppp/peers/ (ex. YOUR_FILE_CONFIG)
PPTP_CONFIG_FILE="";

# If the VPN is OpenVPN type, define the OVPN file location (ex. /home/folder/file.ovpn)
OVPN_FILE="";

# VPN Connection Test
# Define the host (Local VPN IP or Hostname) you want to use to test your VPN Connection (ex. 192.168.0.2)
# If the connection to the defined host is down, the script will try to restart the VPN Connection
VPN_TEST_HOST="";

# VPN Connection Check Date and Time
CHECK_DATE=`date +%F::%r`

# Check if VPN Connection is up.
# If not, try to restablish the VPN Connection
if ping -qnw1 -c1 $VPN_TEST_HOST 2>&1 >/dev/null
then
        echo "Link is up @ $CHECK_DATE" >> /var/log/vpn_checking.log
else
        echo "Link is down $PPTP_CONFIG_FILE @ $CHECK_DATE" >> /var/log/vpn_checking.log

        # Restablish the VPN Connection
        if [ $VPN_TYPE = "pptp" ]
        then
                echo "Restarting VPN $VPN_TYPE $PPTP_CONFIG_FILE @ $CHECK_DATE" >> /var/log/vpn_checking.log
                /usr/sbin/pppd call $PPTP_CONFIG_FILE >> /var/log/vpn_checking.log
        else
                echo "Restarting VPN $VPN_TYPE $OVPN_FILE @ $CHECK_DATE" >> /var/log/vpn_checking.log
                openvpn $OVPN_FILE >> /var/log/vpn_checking.log
        fi
fi
