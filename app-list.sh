#
#  Menu to show open windows in Labwc pipe menu using wlrctl
#
#  https://git.sr.ht/~brocellous/wlrctl
#
#  some documentation for wlrctl is here: https://manpages.ubuntu.com/manpages/noble/man1/wlrctl.1.html
#
#  <menu id="app-list" label="Windows" execute="[path]app-list.sh"/>
#
#  Before the seperator are minimised windows and below are visible windows - minimised windows have a dot next to them.
#

echo '<openbox_pipe_menu>'
wlrctl toplevel list state:minimized  |
while read line; 
do 
appid=$(echo $line | cut -d ':' -f1)
apptitle=$(echo $line | cut -d ':' -f2-| sed '1s/.//' )
echo "<item label="\""&#8226; $appid $apptitle"\"">"
echo "<action name="\""Execute"\""><execute>"
echo "wlrctl window focus app_id:$appid state:minimized `title:'$apptitle'`"
echo "</execute></action></item>"
done
echo "<separator/>"
wlrctl toplevel list state:-minimized  |
while read line; 
do 
appid=$(echo $line | cut -d ':' -f1)
apptitle=$(echo $line | cut -d ':' -f2-| sed '1s/.//' )
echo "<item label="\""$appid $apptitle"\"">"
echo "<action name="\""Execute"\""><execute>"
echo "wlrctl window focus app_id:$appid `title:'$apptitle'` "
echo "</execute></action></item>"
done

echo '</openbox_pipe_menu>'
