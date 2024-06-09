#!/bin/bash

# oh man what is all this? 
# maybe you want to move seamlessly between gnome and labwc, i dunno, it's not my business
# there a lot of 'bad' practice here, but it works so heyho.  
#  <menu id="fav-menu" label="Pinned" execute="labwcfav.sh"/>

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
# wtf is this mess?
NM=$(echo ${pinned[$appid]})
NMW=$(echo $NM | sed 's/\.desktop//')
PATHL=($HOME/.local/share/applications/)
PATHA=(/usr/share/applications/)
PATHFP=(/var/lib/flatpak/app/"$NMW"/current/active/export/share/applications/)
PATHLFP=($HOME/.local/share/flatpak/app/"$NMW"/current/active/files/share/applications/)

# check in home first

if  [ -f $PATHL${pinned[$appid]} ]; then
        PATH1="$PATHL"
        item

elif  [ -f $PATHLFP${pinned[$appid]} ]; then
        PATH1="$PATHLFP"
        item      
      echo   "$PATHLFP$PATHLFP${pinned[$appid]} "
# check in flatpaks next (should this be first?)
  elif  [ -f $PATHFP${pinned[$appid]} ]; then
        PATH1="$PATHFP"
   item 
#check system  
 elif  [ -f $PATHA${pinned[$appid]} ]; then
        PATH1="$PATHA"
   item
   else
# if we can't find the .desktop just give up       
echo "-----------------------------------"
echo   "$PATHLFP${pinned[$appid]} "    
fi
done

echo "</openbox_pipe_menu>"
