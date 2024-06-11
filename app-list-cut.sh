#!/bin/bash
# Alternative Client-list menu based on lswt https://sr.ht/~leon_plickat/lswt/ 
# and wlctrl https://todo.sr.ht/~brocellous/wlrctl/7.
# it's incredibly hacky but for the most part seems to work. 
# [-] signifies minimised window [+] shoes the current active window
# Active,title,app-id,fullscreen,max,min
# lswt -c AtafmM
# known issues - there are problems, with some terminal matches.

exclude=("re.sonny.Retro")
wlist=$(lswt -c AtafmM | sed 's.\\,.※.g')
tm="org.gnome.Console"
echo '<openbox_pipe_menu id="window-list">'

# set the Internal Field Separator to newline
IFS=$'\n' 
for LINE in $wlist
do
apptitle=$(echo "$LINE" | cut -d"," -f2 | sed 's/&/\&amp;/g; s/</\&lt;/g; s/>/\&gt;/g; s/"/\&quot;/g; s/'"'"'/\&#39;/g; s.※.,.g'  )
appid=$(echo "$LINE" | cut -d"," -f3 | sed 's/&/\&amp;/g; s/</\&lt;/g; s/>/\&gt;/g; s/"/\&quot;/g; s/'"'"'/\&#39;/g')
minimized=$(echo "$LINE" | cut -d"," -f5)
active=$(echo "$LINE" | cut -d"," -f1)
max=$(echo "$LINE" | cut -d"," -f6)
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
# if this isn't here it freaks out, but why?  
  else 
	VIS=""
   STATE="state:-active"
   fi
   
if  [[ !  ${exclude[@]} =~ $appid ]]
then   
   echo "<item label="\""$(echo $VIS $appid  | sed 's/org.gnome.//g') - $apptitle"\"">"
   echo "<action name="\""Execute"\""><execute>"
     
# there is some kind of issue with at least console/kgx which works from the command line but not as a pipe menu
# this actualy just fails and falls back to appid
     
     if [[ "$appid" =~ "$tm" ]]
      then
         echo "wlrctl window focus app_id:$appid "$STATE" `title:"\""$apptitle"\""` "
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
