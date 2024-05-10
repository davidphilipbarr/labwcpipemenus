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

TERM="org.gnome.Console"
#wli=$(wlrctl toplevel list state:minimized)
terminal=$(wlrctl toplevel list state:-minimized | grep "$TERM")
terminali=$(wlrctl toplevel list state:minimized | grep "$TERM")
appnames()
{
appid=$(echo $line | cut -d ':' -f1)
apptitle=$(echo $line | cut -d ':' -f2-| sed '1s/.//' | sed 's/&/\&amp;/g; s/</\&lt;/g; s/>/\&gt;/g; s/"/\&quot;/g; s/'"'"'/\&#39;/g')
}

oitem()
{
echo "<item label="\""$(echo $appid  | sed 's/org.gnome.//g') - $apptitle"\"">"
echo "<action name="\""Execute"\""><execute>"
echo "wlrctl window focus app_id:$appid `title:'$apptitle'` "
echo "</execute></action></item>"
}
iitem()
{
echo "<item label="\""[-] $(echo $appid  | sed 's/org.gnome.//g') - $apptitle"\"">"
echo "<action name="\""Execute"\""><execute>"
echo "wlrctl window focus app_id:$appid `title:'$apptitle'` "
echo "</execute></action></item>"
}
echo '<openbox_pipe_menu id="window-list">'
if  [ ! -z "$terminal" ];
then
echo "<menu id='terminals' label='Terminals'>"
wlrctl toplevel list state:-minimized  |
while read line; 
do 
appnames
if [ $appid = "$TERM" ];
then
oitem
fi
done
echo '</menu> '
fi
wlrctl toplevel list state:-minimized  |
while read line; 
do 
appnames
if [ $appid != "$TERM" ];
then
oitem
fi
done
echo "<separator />"
if  [ ! -z "$terminali" ];
then
echo "<menu id='terminals' label='[-] Terminals'>"
wlrctl toplevel list state:minimized  |
while read line; 
do 
appnames
if [ $appid = "$TERM" ];
then
iitem
fi
done
echo '</menu> '
fi


wlrctl toplevel list state:minimized  |
while read line; 
do 
appnames
if [ $appid != "$TERM" ];
then
iitem
fi
done
 
echo "<separator />"


echo "<item label='Move Workspace Right'>"
echo "<item label='Move Workspace Left'>" 
echo '<action name="GoToDesktop" to="left" wrap="yes" />'
echo "</item>"
echo '<action name="GoToDesktop" to="right" wrap="yes" />'
echo "</item>"
echo '</openbox_pipe_menu>'
