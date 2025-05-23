#!/bin/bash

function dialog_box() {
    dialog --title "title" --msgbox "hey there user how are you today?" 0 0
    exit 2
}
function menu(){
    dialog --menu "choose function" 0 0 0 1 "ping all" 2 "add site" 3 "edit site" 4 "remove site"
}

menu
# dialog_box 
# echo "$?"
# if [ "$?" == "3" ]
# then

# fi