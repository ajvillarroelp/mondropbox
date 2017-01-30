#!/bin/bash

desktopfinal=$HOME/.local/share/applications/mondropbox.desktop

#TARGET=$(ps -ef|grep mondropbox.pl |grep -v grep|tr -s " "|cut -d" " -f 2)

if [[ $1 == "on" ]] ; then

	#kill -s 10 $TARGET
	rm -f "$HOME/.mondropbox/mondropbox.disable"
	sed -i 's/Icon=dropbxoff/Icon=dropbox/' $desktopfinal;touch $desktopfinal
else 

	#kill -s 12 $TARGET
	touch "$HOME/.mondropbox/mondropbox.disable"
	sed -i 's/Icon=dropbox/Icon=dropbxoff/' $desktopfinal;touch $desktopfinal
fi




