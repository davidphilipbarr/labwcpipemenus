sample=$(lswt -j)
echo '<openbox_pipe_menu id="window-list">'


for row in $(echo "${sample}" | jq -r '.toplevels[] | @base64'); do
    _jq() {
     echo ${row} | base64 --decode | jq -r ${1}
    }
 #  echo $(_jq '.title')
 #  echo $(_jq '."app-id"')
 #  echo $(_jq '.minimized')
   apptitle=$(_jq '."title"')
   appid=$(_jq '."app-id"')
   minimized=$(_jq '.minimized')

   if [ "$minimized" = "true" ]
   then
	   echo "$minimized"
	   
	   HIDDEN="[-]"
	   STATE="state:minimized"
   else
	   HIDDEN=""
	   STATE="" 
   fi
   
   echo "<item label="\""$(echo $HIDDEN $appid  | sed 's/org.gnome.//g') - $apptitle"\"">"
   echo "<action name="\""Execute"\""><execute>"
   echo "wlrctl window focus app_id:$appid $STATE `title:'$apptitle'` "
   echo "</execute></action></item>"
   
done


echo '</openbox_pipe_menu>'
