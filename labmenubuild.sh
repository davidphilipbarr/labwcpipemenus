ignore_files=$(mktemp)
trap "rm -f $ignore_files" EXIT
cat <<'EOF' >${ignore_files}
gammastep-indicator.desktop
libreoffice-startcenter.desktop
cmake-gui.desktop
electron27.desktop
org.gtk.IconBrowser4.desktop
org.gtk.gtk4.NodeEditor.desktop
org.gtk.PrintEditor4.desktop
org.gtk.WidgetFactory4.desktop
bssh.desktop
bvnc.desktop
qv4l2.desktop
qvidcap.desktop
pcmanfm-qt-desktop-pref.desktop
pcmanfm-desktop-pref.desktop
libfm-pref-apps.desktop
org.xfce.mousepad-settings.desktop
avahi-discover.desktop
org.codeberg.dnkl.footclient.desktop
org.codeberg.dnkl.foot-server.desktop
lstopo.desktop
gtk-lshw.desktop
urxvtc.desktop
urxvt-tabbed.desktop
xterm.desktop
rofi.desktop
rofi-theme-selector.desktop
chrome-aghbiahbpaijignceidepookljebhfak-Default.desktop
chrome-agimnkijcaahngcdmfeangaknmldooml-Default.desktop
chrome-blgknnpkkjkibhpfancinjhilngnoick-Default.desktop
chrome-dhbnadlgmgbbeoomclfdfjdmoklpjoeg-Default.desktop
chrome-eilembjdkfgodjkcjnpgpaenohkicgjd-Default.desktop
chrome-eppojlglocelodeimnohnlnionkobfln-Default.desktop
chrome-fhihpiojkbmbpdjeoajapmgkhlnakfjf-Default.desktop
chrome-fmgjjmmmlfnkbppncabfkddbjimcfncm-Default.desktop
chrome-hiieljobdllfifmbcmlpaniafdiddcki-Default.desktop
chrome-kajebgjangihfbkjfejcanhanjmmbcfd-Default.desktop
chrome-lgnggepjiihbfdbedefdhcffnmhcahbm-Default.desktop
chrome-lljldmnnhjkandejalbjlndemhlcjepa-Default.desktop
chrome-mpnpojknpmmopombnjdcgaaiekajbnjb-Default.desktop
chrome-ncmjhecbjeaamljdfahankockkkdmedg-Default.desktop
chrome-njbkenhmpdlalcafnbnplkmfjgeeofdn-Default.desktop
chrome-pjibgclleladliembfgfagdaldikeohf-Default.desktop
io.ulauncher.Ulauncher.desktop
texdoctk.desktop
yelp.desktop
debi.desktop
EOF


cd  ~/.config/labwc

rm menu.xml

labwc-menu-generator -n -i "${ignore_files}" > ~/.config/labwc/rootmenu.xml

echo "
" >> menu.xml
echo $(cat rootmenu.xml) >> menu.xml
echo "
" >> menu.xml
sed -i 's/<\/openbox_menu>//g' menu.xml

echo $(cat rightmenu.xml) >> menu.xml
echo "
" >> menu.xml
echo "</openbox_menu>" >> menu.xml


labwc --reconfigure
