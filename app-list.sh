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

exclude=("re.sonny.Retro Skype")
tm="org.gnome.Console"

appnames()
{
appid=$(echo $line | cut -d ':' -f1)
# clean up gnome names
appidt=$(echo $line | cut -d ':' -f1 | sed 's/org.gnome.//g')
apptitle=$(echo $line | cut -d ':' -f2-| sed '1s/.//' | sed 's/&/\&amp;/g; s/</\&lt;/g; s/>/\&gt;/g; s/"/\&quot;/g; s/'"'"'/\&#39;/g')
}
app()
{
if  [[ !  ${exclude[@]} =~ $appid ]]
then 
echo "<item label="\""$ico $appidt - $apptitle"\"">"
echo "<action name="\""Execute"\""><execute>"

# for no reason i can fathom nautilus specifically needs the no backtick method, 
# so we hack rather than figure out why?

if [[ "$appid" =~ "$tm" ]]
     then
   # tbh i think this just fails and falls back to appid?      
echo "wlrctl window focus app_id:$appid $state `title:'$apptitle'`"
     else
  echo "wlrctl window focus app_id:$appid $state title:'$apptitle'"   

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
state="state:minimized"
ico="[-]"
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
min

# add a load of bumf at the end 
printf '%b\n' '
<separator/>
<item label="Move Workspace Right">
<item label="Move Workspace Left"> 
<action name="GoToDesktop" to="left" wrap="yes" />
</item>
<action name="GoToDesktop" to="right" wrap="yes" />
</item>
</openbox_pipe_menu>'



