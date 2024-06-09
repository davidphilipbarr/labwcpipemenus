#!/bin/bash
pinned=( $(dconf read /org/gnome/shell/favorite-apps | sed "s/'//g" | sed "s/,//g" | sed "s/\[//g" | sed "s/\]//g") )
echo '<openbox_pipe_menu id="pinned-apps-list">'

item()
{
command=$(grep '^Exec' "$PATH1${pinned[$appid]}" | tail -1 | sed 's/^Exec=//' | sed 's/%.//' | sed 's/^"//g' | sed 's/" *$//g'  | sed 's/&/\&amp;/g; s/</\&lt;/g; s/>/\&gt;/g; s/"/\&quot;/g; s/'"'"'/\&#39;/g' )
name=$(grep -m 1 '^Name=' "$PATH1${pinned[$appid]}" | tail -1 | sed 's/^Name=//' | sed 's/%.//' | sed 's/^"//g' | sed 's/" *$//g' | sed 's/&/\&amp;/g; s/</\&lt;/g; s/>/\&gt;/g; s/"/\&quot;/g; s/'"'"'/\&#39;/g')

echo "<item label="\""$name"\"">"
echo "<action name="\""Execute"\""><execute>"
echo "$command"
echo "</execute></action></item>"
}

for appid in "${!pinned[@]}"
do
PATHL=(/home/david/.local/share/applications/)
PATHA=(/usr/share/applications/)
PATHFP=(/var/lib/flatpak/app/"${pinned[$appid]}"/current/active/export/share/applications)

# check in home first

if  [ -f $PATHL${pinned[$appid]} ]; then
        PATH1="$PATHL"
        item
# check in flatpaks next (should this be first?)
  elif  [ -f $PATHFP${pinned[$appid]} ]; then
        PATH1="$PATHFP"
   item 
#check system  
 elif  [ -f $PATHA${pinned[$appid]} ]; then
        PATH1="$PATHA"
   item
# if we can't find the .desktop just give up      
fi
done

echo "</openbox_pipe_menu>"
