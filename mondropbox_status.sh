#!/bin/bash

message=$(dropbox status)
zenity  --title "Mondropbox" --info --text "Dropbox Status: \n$message"
