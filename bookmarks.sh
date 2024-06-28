#!/bin/bash

echo '<openbox_pipe_menu>'

filemanager="nautilus"

for bookmark in `sed 's/[ ][^ ]*$//' .config/gtk-3.0/bookmarks` ; do
name=$(basename ${bookmark})
if [[ "$name" = "file:" ]] then 
name="/"
else name="$name"
fi
echo "<item label='$name'>"
  echo '<action name="Execute"><execute>'
  echo "$filemanager ${bookmark}"
  echo '</execute></action>'
  echo '</item>'
done

echo '</openbox_pipe_menu>'
