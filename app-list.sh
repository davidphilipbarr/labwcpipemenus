#  I'm sure there are better ways of doing this, but here we are
#
#  Menu to show open windows in Labwc pipe menu using wlrctl
#
#  https://git.sr.ht/~brocellous/wlrctl
#
#  some documentation for wlrctl is here: https://manpages.ubuntu.com/manpages/noble/man1/wlrctl.1.html
#
#  <menu id="app-list" label="Windows" execute="[path]app-list.sh"/>
#

echo '<openbox_pipe_menu id="window-list">'

wla=$(wlrctl toplevel list state:-minimized)
wli=$(wlrctl toplevel list state:minimized)
wlrctl toplevel list state:-minimized  |
while read line; 
do 

appid=$(echo $line | cut -d ':' -f1)
appidt=$(echo $line | cut -d ':' -f1 |sed 's/org.gnome.//g')
apptitle=$(echo $line | cut -d ':' -f2-| sed '1s/.//' | sed 's/\&/\&amp;/g'   )

echo "<item label="\""$appidt - $apptitle"\"">"
echo "<action name="\""Execute"\""><execute>"
echo "wlrctl window focus app_id:$appid `title:'$apptitle'` "
echo "</execute></action></item>"

done
if [ -z "$wla" ];
then 
echo "<item label='No open windows'></item>"
fi
echo "<separator/>"

wlrctl toplevel list state:minimized  |
while read line; 
do 
appid=$(echo $line | cut -d ':' -f1)
appidt=$(echo $line | cut -d ':' -f1 |sed 's/org.gnome.//g')
apptitle=$(echo $line | cut -d ':' -f2-| sed '1s/.//' )
echo "<item label="\""* $appidt - $apptitle"\"">"
echo "<action name="\""Execute"\""><execute>"
echo "wlrctl window focus app_id:$appid state:minimized `title:'$apptitle'`"
echo "</execute></action></item>"
done
if  [ ! -z "$wli" ];
then 
echo "<separator/>"
fi


echo "<item label='Move Workspace Right'>"

  echo "<item label='Move Workspace Left'>" 
      echo '<action name="GoToDesktop" to="left" wrap="yes" />'
 echo "</item>"

 echo '<action name="GoToDesktop" to="right" wrap="yes" />'
 
 echo "</item>"
 






echo '</openbox_pipe_menu>'
