# VPN-PPTP-OpenVPN-Check-and-Restart

Simple script to check if our VPN client is running, and try restablish VPN Connection if link is down

This simple script works with VPN type PPTP and OpenVPN

CRON Example to to run this script every 15 minutes:

0,15,30,45 * * * * /bin/bash /YOUR_LOCATION/vpn_checking.sh
