#!/bin/bash
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

exclude=("re.sonny.Retro")
fm="org.gnome.Nautilus"
appnames()
{
appid=$(echo $line | cut -d ':' -f1)
appidt=$(echo $line | cut -d ':' -f1 | sed 's/org.gnome.//g')
apptitle=$(echo $line | cut -d ':' -f2-| sed '1s/.//' | sed 's/&/\&amp;/g; s/</\&lt;/g; s/>/\&gt;/g; s/"/\&quot;/g; s/'"'"'/\&#39;/g')
}
app()
{
if  [[ !  ${exclude[@]} =~ $appid ]]
then 
echo "<item label="\""$appidt - $apptitle"\"">"
echo "<action name="\""Execute"\""><execute>"
if [ "$appid" = "$fm" ]
     then
echo "wlrctl window focus app_id:$appid title:'$apptitle'"
     else
echo "wlrctl window focus app_id:$appid `title:'$apptitle'`"
fi
echo "</execute></action></item>"
fi
}
vis()
{
#list windows that are 'on the desktop'
wlrctl toplevel list state:-minimized |
while read line; 
do 
appnames
app
done
}
min()
{
#list windows that are mimimised
wlrctl toplevel list state:minimized  |
while read line; 
do 
appnames
app
done
}
#begin the menu!  
echo '<openbox_pipe_menu id="window-list">'
vis
echo "<separator/>"
min
# add a load of bumf at the end 
printf '%b\n' '
<separator/>
<item label="Move Workspace Right">
<item label="Move Workspace Left">" 
<action name="GoToDesktop" to="left" wrap="yes" />
</item>
<action name="GoToDesktop" to="right" wrap="yes" />
</item>
<!--
<item label="Clear Workspace">
<action name="Execute"><execute>wlrctl window minimize
</execute></action></item>
-->
</openbox_pipe_menu>'
