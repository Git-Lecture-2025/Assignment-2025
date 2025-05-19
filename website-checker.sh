#!/bin/bash

source ./utils.sh
while true;
do
    echo "Available choices:"
    echo "1) Add a website"
    echo "2) Edit a website"
    echo "3) Remove a website"
    echo "4) Check status"
    echo "5) Exit"
    echo -ne "Enter your choice: "
    read choice
    
    case $choice in
        1)
            add_website
            ;;
        2)
            edit_website
            ;;
        3)
            remove_website
            ;;
        4)
            check_websites
            ;;
        5)
            exit
            ;;
        *)
            echo "Wrong choice"
            ;;
    esac
done
