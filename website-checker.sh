#!/bin/bash

touch ~/website_checker_list

add_website() {
    echo -ne "Enter your website: "
    read website

    curl -fSsL $website > /dev/null
    if ! [[ $? = 6 ]]; then
        echo $website >> ~/website_checker_list
        echo -e "\e[32m✅ Website added\e[0m"
    else
        echo -e "\e[31m🛑 Input is not a website\e[0m"
    fi
}

show_websites() {
    cat ~/website_checker_list -n
}

remove_website() {  
    lines=($(awk 'END { print NR }' ~/website_checker_list))
    if [[ $lines -lt 1 ]]; then
        echo -e "\e[31m🛑 No websites to remove\e[0m"
        return
    fi
    show_websites
    echo -ne "Which website do you want to remove? "
    read n
    re='^[0-9]+$'
    if ! [[ $n =~ $re ]] ; then
        echo -e "\e[31mInvalid Choice ❌\e[0m"
        return
    fi
    if [[ $n = 0 || $n -gt $lines ]];
    then
        echo -e "\e[31mInvalid choice ❌\e[0m"
    else
        echo -ne "Are you sure? [y/N]? "
        read y
        if [[ "$y" = "y" ]]
        then
            sed -ie $n'd' ~/website_checker_list
            echo -e "\e[31m✅ Website removed\e[0m"
        else
            echo "Not deleted ❌"
        fi
    fi
}

edit_website() {
    lines=($(awk 'END { print NR }' ~/website_checker_list))

    if [[ $lines -lt 1 ]]; then
        echo -e "\e[31m🛑 No websites to edit\e[0m"
        return
    fi
    show_websites
    echo -ne "Which website do you want to edit? "
    read n
    re='^[0-9]+$'
    if ! [[ $n =~ $re ]] ; then
        echo -e "\e[31mInvalid Choice ❌\e[0m"
        return
    fi

    if [[ $n = 0 || $n -gt $lines ]];
    then
        echo -e "\e[31mInvalid choice ❌\e[0m"
    else
        entry=($(sed -n "${n}p;q" ~/website_checker_list))
        read -e -i $entry -p "Edit entry: " new_entry
        curl -fsSL $new_entry > /dev/null
        if ! [[ $? = 6 ]]; then
            sed -i "${n}s~.*~${new_entry}~" ~/website_checker_list
            echo -e "\e[32m✅ Website edited\e[0m"
        else
            echo -e "\e[31m🛑 Invalid website\e[0m"
        fi
    fi
}

check_websites() {
    echo "-------------------------------------"
    date
    echo "Checking if saved websites are online"
    cat ~/website_checker_list |
        while read in; do
            curl -fsSL $in > /dev/null
            [[ $? = 0 ]] && result="\e[32mSUCCESS ✅\e[0m" || result="\e[31mFAILED ❌\e[0m"
            echo -e $in $result
        done
    echo "-------------------------------------"
}

add_cron() {
    path=$(realpath $0)
    user=$(whoami)
    if ( crontab -l 2> /dev/null | grep --quiet "$path" ); then
        echo -e "\e[31m🛑 Cronjob already exists, Remove it to add a new one\e[0m"
        return
    else
        echo -ne "Enter the time interval in minutes [Default = 30m]: "
        read schedule
        if [[ $schedule = "" ]]; then
            schedule="30"
        fi
        (crontab -l 2> /dev/null; echo "*/$schedule * * * * $path ping > /home/$user/website_checker_logs") | crontab -
        echo -e "\e[32m✅ Cronjob Added\e[0m"
    fi
}

remove_cron() {
    path=$(realpath $0)
    if ( crontab -l | grep --quiet "$path" ); then
        (crontab -l 2> /dev/null | grep -v "$path") | crontab -
        echo -e "\e[32m✅ Cronjob removed\e[0m"
    else
        echo -e "\e[31mCronjob doesnt exist ❌\e[0m"
    fi
}

if [[ $1 = "ping" ]]; then
    check_websites
    exit
fi

while true;
do
    reset
    echo -e "\e[32m"
    echo "__________.__                             "
    echo "\\______   \\__| ____    ____   ___________ "
    echo "|     ___/  |/    \\  / ___\\_/ __ \\_  __ \\"
    echo "|    |   |  |   |  \\/ /_/  >  ___/|  | \\/"
    echo "|____|   |__|___|  /\\___  / \\___  >__|   "
    echo "                 \\//_____/      \\/       "
    echo -e "\e[0m"

    echo "Available choices:"
    echo "1) Add a website ➕"
    echo "2) Edit a website ✏️"
    echo "3) Remove a website ❌"
    echo "4) Check status ✅"
    echo "5) Add cronjob ⏱️"
    echo "6) Remove cronjob ⌛️"
    echo "7) Exit 🚪"
    echo -ne "Enter your choice: "
    read choice
    
    reset
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
            add_cron
            ;;
        6)
            remove_cron
            ;;
        7)
            exit
            ;;
        *)
            echo "Wrong choice"
            ;;
    esac
    echo "Press ENTER to go back to main menu"
    read
done
