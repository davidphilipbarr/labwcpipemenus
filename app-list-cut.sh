#!/bin/bash
# Alternative Client-list menu based on lswt https://sr.ht/~leon_plickat/lswt/ 
# and wlctrl https://todo.sr.ht/~brocellous/wlrctl/7.
# it's incredibly hacky but for the most part seems to work. 
# [-] signifies minimised window 👁 signifies the current active window
# Active,title,app-id,fullscreen,max,min
# lswt -c AtafmM

exclude=("re.sonny.Retro")
# add ※ instead of commas to allow cut to work with delimiter.
wlist=$(lswt -c AtafmM | sed 's.\\,.※.g')
echo '<openbox_pipe_menu id="window-list">'

IFS=$'\n' 
for LINE in $wlist
do
# so earlier on we swapped "," for a snowflake thing now we are swapping it back and escaping the xml stuff
apptitle=$(echo "$LINE" | cut -d"," -f2 | sed 's/&/\&amp;/g; s/</\&lt;/g; s/>/\&gt;/g; s/"/\&quot;/g; s/'"'"'/\&#39;/g; s.※.,.g'  )
appid=$(echo "$LINE" | cut -d"," -f3 | sed 's/&/\&amp;/g; s/</\&lt;/g; s/>/\&gt;/g; s/"/\&quot;/g; s/'"'"'/\&#39;/g')
minimized=$(echo "$LINE" | cut -d"," -f5)
active=$(echo "$LINE" | cut -d"," -f1)
max=$(echo "$LINE" | cut -d"," -f6)
# we're actually checking for fullscreen as well maybe it should show it - if it's not too slow?
if [ "$minimized" = "true" ]
  then
        VIS="[-]"
	STATE="state:minimized"
  elif [ "$active" = "true" ] 
  then
	VIS="👁"
	    elif [ "$max" = "true" ] 
  then
	VIS="🗖"
# if this isn't here it freaks out, but why? We're also setting state not active to add a little bit more chance of getting the right window  
  else 
	VIS=""
   STATE="state:-active"
   fi
   
if  [[ !  ${exclude[@]} =~ $appid ]]
then   
   echo "<item label="\""$(echo $VIS $appid  | sed 's/org.gnome.//g') - $apptitle"\"">"
   echo "<action name="\""Execute"\""><execute>"
     
# tilde expands to $home, so if the window includes a tilde we just totally abandon trying to match the title.
# it's less than ideal, but in the case of multiple windows like terminals it will let us at least pull them up from iconfified
# even if we sometimes get the wrong one - a rough match is better than none??
# TODO: find better solution...
     
     if [[ "$apptitle" =~ "~" ]]
      then
         echo "wlrctl window focus app_id:$appid "$STATE" "
      else
          echo "wlrctl window focus app_id:$appid "$STATE" title:"\""$apptitle"\"" "
	     
   fi
   echo "</execute></action></item>"
   fi

done

echo "<separator />"
echo "<item label='Move Workspace Left'>" 
echo '<action name="GoToDesktop" to="left" wrap="yes" />'
echo "</item>"
echo "<item label='Move Workspace Right'>"
echo '<action name="GoToDesktop" to="right" wrap="yes" />'
echo "</item>"
#echo "<separator />"
#echo "<item label='Clear Workspace'>"
#echo "<action name="\""Execute"\""><execute>" 
#echo "wlrctl window minimize"
#echo "</execute></action></item>"
echo '</openbox_pipe_menu>'
