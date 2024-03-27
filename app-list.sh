echo '<openbox_pipe_menu>'
wlrctl toplevel list state:minimized  |
while read line; 
do 
appid=$(echo $line | cut -d ':' -f1)
apptitle=$(echo $line | cut -d ':' -f2-| sed '1s/.//' )
echo "<item label="\""$appid $apptitle"\"">"
echo "<action name="\""Execute"\""><execute>"
echo "wlrctl window focus app_id:$appid state:minimized `title:'$apptitle'`"
echo "</execute></action></item>"
done
echo "<separator/>"
wlrctl toplevel list state:-minimized  |
while read line; 
do 
appid=$(echo $line | cut -d ':' -f1)
apptitle=$(echo $line | cut -d ':' -f2-| sed '1s/.//' )
echo "<item label="\""$appid $apptitle"\"">"
echo "<action name="\""Execute"\""><execute>"
echo "wlrctl window focus app_id:$appid `title:'$apptitle'` "
echo "</execute></action></item>"
done

echo '</openbox_pipe_menu>'
