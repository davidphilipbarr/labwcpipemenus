#!/bin/bash

echo '<openbox_pipe_menu>'

TIME=$(date +%H:%M\ %B\ %d,\ %Y)


  echo "<item label='$TIME'>"
  echo '<action name="Execute"><execute>'
  echo "gnome-calendar"
  echo '</execute></action>'
  echo '</item>'
  echo '<menu id="bluetooth" label="Bluetooth">'
bluetoothctl devices Connected | while read -r uuid
do
echo "<item label='$uuid'>"  
echo '</item>'
done
echo "   <separator/>"
echo "<item label='Bluetooth Settings'>"
  echo '<action name="Execute"><execute>'
  echo "overskride"
  echo '</execute></action>'
  echo '</item>'

 echo '</menu> '
vol=$(wpctl get-volume @DEFAULT_AUDIO_SINK@)
echo "<item label='$vol'>"
  echo '<action name="Execute"><execute>'
  echo "pavucontrol"
  echo '</execute></action>'
  echo '</item>'

Battery=$(acpi -b | grep "Battery" | sed -nr '/Battery/s/.*(\<[[:digit:]]+%).*/\1/p')
echo "<item label=\"Battery: $Battery\"/>"

echo '  <item label="Reconfigure">'
echo '    <action name="Reconfigure" />'
echo '  </item>'
echo '  <item label="Exit">'
echo '    <action name="Exit" />'
echo '  </item>'
echo '</openbox_pipe_menu>'





