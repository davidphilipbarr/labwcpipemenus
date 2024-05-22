#!/bin/bash
vpn=$(ip link show | grep tun0)
echo '<openbox_pipe_menu>'
    # CLOCK
TIME=$(date +%H:%M\ %B\ %d,\ %Y)


 echo "<item label='$TIME'>"
  echo '<action name="Execute"><execute>'
  echo "gnome-calendar"
  echo '</execute></action>'
  echo '</item>'
      # end CLOCK
  echo "   <separator/>"
  # SHOW IF VPN is ACTIVE
 
if [ "$vpn" ]; 
then
vpnstatus="VPN Active"

echo "<item label='VPN Active &#128994;'>"
  echo '<action name="Execute"><execute>'
  echo "sudo killall openvpn"
  echo '</execute></action>'
  echo '</item>'

fi
    # END SHOW IF VPN is ACTIVE
    
# BATTERY STUFF
  
  Battery=$(acpi -b | grep "Battery" | sed -nr '/Battery/s/.*(\<[[:digit:]]+%).*/\1/p')
echo "<item label=\"Battery: $Battery\"/>"

echo "   <separator/>"
  # END BATTERY STUFF
  
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

# BLUETOOTH STUFF


echo "   <separator/>"

  # VOLUME

echo "<item label='Volume Settings'>"
  echo '<action name="Execute"><execute>'
  echo "pavucontrol"
  echo '</execute></action>'
  echo '</item>'
    # END VOLUME
echo "<item label='Bluetooth Settings'>"
  echo '<action name="Execute"><execute>'
  echo "blueman-manager"
  echo '</execute></action>'
  echo '</item>'
 # END BLUETOOTH STUFF
 

# NETWORK STUFF  


echo "<item label='Network Manager'>"
  echo '<action name="Execute"><execute>'
  echo "nm-connection-editor"
  echo '</execute></action>'
  echo '</item>'
 
# END NETWORK STUFF  
  

echo '<menu id="power" label="Power">'
echo '  <item label="Log Out">'
echo '    <action name="Exit" />'
echo '  </item>'

echo "<item label='Lock Screen'>"
  echo '<action name="Execute"><execute>'
  echo "wlopm --off"
  echo '</execute></action>'
  echo '</item>'
  
   echo '  <item label="Reconfigure">'
echo '    <action name="Reconfigure" />'
echo '  </item>'
  
 echo '</menu> '
 


echo '</openbox_pipe_menu>'





