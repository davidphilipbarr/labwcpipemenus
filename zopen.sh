#!/bin/bash

TITLE="Start a VPN Connection"
CHOICE=$(zenity --file-selection --directory --title="Select your desired VPN config" --file-filter="*.conf")
VPNFILE=$(basename "$CHOICE")
echo $VPNFILE
LEVEL1=$(echo "$VPNFILE" | sed 's/config/openvpn/')
FILE=$(echo "$VPNFILE" | sed 's/_config_linux//')
clear
cd /home/david/Downloads/ovpn/$LEVEL1/$VPNFILE/
sudo openvpn --config "$FILE.conf" | zenity --text-info --title="VPN config"

