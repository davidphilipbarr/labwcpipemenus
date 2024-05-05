#!/bin/bash
# Alternative Client-list menu based on lswt https://sr.ht/~leon_plickat/lswt/ 
# and wlctrl https://todo.sr.ht/~brocellous/wlrctl/7 usuing jq to parse the json output.
# it's incredibly hacky but for the most part seems to work. 
# [-] signifies minimised window [+] shoes the current active window
exclude=("re.sonny.Retro")
wlist=$(lswt -j)
fm="org.gnome.Nautilus"
echo '<openbox_pipe_menu id="window-list">'
for row in $(echo "${wlist}" | jq -r '.toplevels[] | @base64'); do
    _jq() {
     echo ${row} | base64 --decode | jq -r ${1}
    }
   apptitle=$(_jq '.title' | sed 's/&/\&amp;/g; s/</\&lt;/g; s/>/\&gt;/g; s/"/\&quot;/g; s/'"'"'/\&#39;/g')
   appid=$(_jq '."app-id"' | sed 's/&/\&amp;/g; s/</\&lt;/g; s/>/\&gt;/g; s/"/\&quot;/g; s/'"'"'/\&#39;/g')
   minimized=$(_jq '.minimized')
   active=$(_jq '.activated')
  
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
   fi
   echo "</execute></action></item>"
   
         echo "not array $appid"
   fi
done


echo "<separator />"
echo "<item label='Move Workspace Left'>" 
echo '<action name="GoToDesktop" to="left" wrap="yes" />'
echo "</item>"
echo "<item label='Move Workspace Right'>"
echo '<action name="GoToDesktop" to="right" wrap="yes" />'
echo "</item>"
echo "<separator />"
echo "<item label='Clear Workspace'>"
echo "<action name="\""Execute"\""><execute>" 
echo "wlrctl window minimize"
echo "</execute></action></item>"

echo '</openbox_pipe_menu>'
