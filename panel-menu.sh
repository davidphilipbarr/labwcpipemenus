#!/bin/bash
vpn=$(ip link show | grep tun0)
echo '<openbox_pipe_menu>'

TIME=$(date +%H:%M\ %B\ %d,\ %Y)


  echo "<item label='$TIME'>"
  echo '<action name="Execute"><execute>'
  echo "gnome-calendar"
  echo '</execute></action>'
  echo '</item>'
  
  
  vol=$(wpctl get-volume @DEFAULT_AUDIO_SINK@)
echo "<item label='$vol'>"
  echo '<action name="Execute"><execute>'
  echo "pavucontrol"
  echo '</execute></action>'
  echo '</item>'

  
  if [ "$vpn" ]; 
then
vpnstatus="VPN Active"

echo "<item label='VPN Active &#128994;'>"
  echo '<action name="Execute"><execute>'
  echo "/home/david/.local/bin/zopen.sh"
  echo '</execute></action>'
  echo '</item>'


fi
  
  
  
  Battery=$(acpi -b | grep "Battery" | sed -nr '/Battery/s/.*(\<[[:digit:]]+%).*/\1/p')
echo "<item label=\"Battery: $Battery\"/>"

echo "<item label='Screenshot'>"
  echo '<action name="Execute"><execute>'
  echo "/home/david/.local/bin/grimshot.sh"
  echo '</execute></action>'
  echo '</item>'


 echo "<item label='Change Background'>"
  echo '<action name="Execute"><execute>'
  echo "/home/david/bin/setbgz"
  echo '</execute></action>'
  echo '</item>' 
  echo '<menu id="bluetooth" label="Bluetooth">'
bluetoothctl devices Connected | while read -r uuid
do

mac=$(echo $uuid | cut -d " " -f2)
battery=$(bluetoothctl info $mac | grep 'Battery Percentage')


echo "<item label='$uuid &#128267; $battery'>"  
echo '</item>'
done
echo "   <separator/>"
echo "<item label='Bluetooth Settings'>"
  echo '<action name="Execute"><execute>'
  echo "overskride"
  echo '</execute></action>'
  echo '</item>'

 echo '</menu> '
 
 

 
  echo '<menu id="Networks" label="Network">'
 
nmcli -p device | grep 'connected' | while read -r nmc 
do

echo "<item label='$nmc'>"
  echo '<action name="Execute"><execute>'
  echo "xdg-terminal-exec nmtui"
  echo '</execute></action>'
  echo '</item>'
done

echo "   <separator/>"

echo "<item label='Network Manager'>"
  echo '<action name="Execute"><execute>'
  echo "xdg-terminal-exec nmtui"
  echo '</execute></action>'
  echo '</item>'

 echo '<menu id="vpn" label="VPN">'

if [ "$vpn" ]; 
then
vpnstatus="VPN Active &#128994;"
else
vpnstatus="VPN Inactive &#128308;"
fi
echo "<item label='$vpnstatus'>"
  echo '<action name="Execute"><execute>'
  echo "/home/david/bin/zopen.sh"
  echo '</execute></action>'
  echo '</item>'
echo "   <separator/>"
echo "<item label='Open VPN connection'>"
  echo '<action name="Execute"><execute>'
  echo "/home/david/bin/zopen.sh"
  echo '</execute></action>'
  echo '</item>'

echo "<item label='Close VPN'>"
  echo '<action name="Execute"><execute>'
  echo "sudo killall openvpn"
  echo '</execute></action>'
  echo '</item>'

 echo '</menu> '
 echo '</menu> '
 

  

 echo '<menu id="power" label="Power">'

echo '  <item label="Log Out">'
echo '    <action name="Exit" />'
echo '  </item>'

echo "<item label='Lock Screen'>"
  echo '<action name="Execute"><execute>'
  echo "wlopm --off"
  echo '</execute></action>'
  echo '</item>'
 echo '</menu> '
 
 echo '  <item label="Reconfigure">'
echo '    <action name="Reconfigure" />'
echo '  </item>'

echo '</openbox_pipe_menu>'





