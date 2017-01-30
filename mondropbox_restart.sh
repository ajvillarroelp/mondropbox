#!/bin/bash

~/.mondropbox/mondropbox_cmd.sh off
sleep 2
dropbox stop
sleep 5
bash $HOME/bin/Dropbox.sh &
bash ~/bin/MEGAsync.sh &
sleep 2
~/.mondropbox/mondropbox_cmd.sh on
