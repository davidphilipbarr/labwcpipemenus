#!/bin/bash
# Alternative Client-list menu based on lswt https://sr.ht/~leon_plickat/lswt/ 
# and wlctrl https://todo.sr.ht/~brocellous/wlrctl/7 usuing jq to parse the json output.
# it's incredibly hacky but for the most part seems to work. 
# [-] signifies minimised window [+] shoes the current active window
#Active,title,app-id,fullscreen,min,max
# -c AtafmM

exclude=("re.sonny.Retro")
wlist=$(lswt -c AtafmM)
fm="org.gnome.Nautilus"
echo '<openbox_pipe_menu id="window-list">'
# Define the input file

# Read the input file line by line using a for loop
IFS=$'\n' # set the Internal Field Separator to newline
for LINE in $wlist
do
   
apptitle=$(echo "$LINE" | cut -d"," -f2)
appid=$(echo "$LINE" | cut -d"," -f3)
minimized=$(echo "$LINE" | cut -d"," -f5)
active=$(echo "$LINE" | cut -d"," -f1)

if [ "$minimized" = "true" ]
  then
	   HIDDEN="[-]"
	   STATE="state:minimized"
  elif [ "$active" = "true" ] 
  then
	   HIDDEN="[+]"
	   
#if this isn't here it freaks out, but why?  
  else 
	   HIDDEN=""
	   STATE=""
   fi
   
if  [[ !  ${exclude[@]} =~ $appid ]]
then   


   echo "<item label="\""$(echo $HIDDEN $appid  | sed 's/org.gnome.//g') - $apptitle"\"">"
   echo "<action name="\""Execute"\""><execute>"
     
# for no reason i can fathom nautilus specifically needs the no backtick method, 
# so we hack rather than figure out why?
     
     if [ "$appid" = "$fm" ]
      then
         echo "wlrctl window focus app_id:$appid "$STATE" title:'$apptitle' "
      else
          echo "wlrctl window focus app_id:$appid "$STATE" `title:'$apptitle'` "
       #echo "wlrctl window focus app_id:$appid "$STATE" title:'$apptitle' "
	   
	   
   fi
   echo "</execute></action></item>"
   
   fi

done

echo '</openbox_pipe_menu>'
