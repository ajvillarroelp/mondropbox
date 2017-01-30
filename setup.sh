#!/bin/bash

#desktopfrom=/usr/share/applications/dr.desktop
#desktopfinal=$HOME/$client.desktop
desktopfinal=$HOME/.local/share/applications/mondropbox.desktop
planklauncher=$HOME/.config/plank/dock1/launchers/mondropbox.dockitem
#planklauncher=$HOME/$client.dockitem

echo "[Desktop Entry]
Name=Dropbox Monitor
GenericName=Dropbox Monitor
Comment=Dropbox Monitor
Exec=perl $HOME/bin/mondropbox.pl 
Terminal=false
Type=Application
Icon=dropbox
Categories=Network;FileTransfer;
StartupNotify=false
X-Ayatana-Desktop-Shortcuts=Disable;Enable;Status;RestartDropbox;StopDropbox

[Disable Shortcut Group]
Name=Disable Monitor
Exec=bash $HOME/.mondropbox/mondropbox_cmd.sh off

[Enable Shortcut Group]
Name=Disable Monitor
Exec=bash $HOME/.mondropbox/mondropbox_cmd.sh on

[Status Shortcut Group]
Name=Query Dropbox status
Exec=bash $HOME/.mondropbox/mondropbox_status.sh

[RestartDropbox Shortcut Group]
Name=Restart Dropbox
Exec=bash $HOME/.mondropbox/mondropbox_restart.sh

[StopDropbox Shortcut Group]
Name=Shutdown Dropbox & Mon
Exec=bash $HOME/.mondropbox/mondropbox_stop.sh
" > "$desktopfinal"

echo "[PlankItemsDockItemPreferences]
Launcher=file://$desktopfinal"> "$planklauncher" 


mkdir ~/.icons
cp $HOME/.mondropbox/dropbxoff.png ~/.icons
#sed -i 's/Icon=evolution/Icon=chkgmail/' $HOME/.local/share/applications/evolution.desktop;touch $HOME/.local/share/applications/evolution.desktop

#sed -i 's/Icon=chkgmail/Icon=evolution/' $HOME/.local/share/applications/evolution.desktop;touch $HOME/.local/share/applications/evolution.desktop
