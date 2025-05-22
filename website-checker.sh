#!/bin/bash

add_website() {
    echo -ne "Enter your website: "
    read website

    if [[ $website =~ ^https?:\/\/w?w?w?.+ ]]; then
        echo $website >> ~/website_checker_list
        echo -e "\e[32mWebsite added\e[0m"
    else
        echo -e "\e[31mInput is not a website\e[0m"
    fi
}

show_websites() {
    cat ~/website_checker_list -n
}

remove_website() {
    show_websites
    echo -ne "Which website do you want to remove? "
    read n
    lines=($(awk 'END { print NR }' ~/website_checker_list))
    if [[ $n = 0 || $n -gt $lines ]];
    then
        echo -e "\e[31mInvalid choice\e[0m"
    else
        echo -ne "Are you sure? [y/N]? "
        read y
        if [[ "$y" = "y" ]]
        then
            sed -ie $n'd' ~/website_checker_list
            echo -e "\e[31mWebsite removed\e[0m"
        else
            echo "Not deleted"
        fi
    fi
}

edit_website() {
    show_websites
    echo -ne "Which website do you want to edit? "
    read n
    lines=($(awk 'END { print NR }' ~/website_checker_list))
    if [[ $n = 0 || $n -gt $lines ]];
    then
        echo -e "\e[31mInvalid choice\e[0m"
    else
        entry=($(sed -n "${n}p;q" ~/website_checker_list))
        read -e -i $entry -p "Edit entry: " new_entry
        if [[ $new_entry =~ ^https?:\/\/w?w?w?.+ ]]; then
            sed -i "${n}s~.*~${new_entry}~" ~/website_checker_list
            echo -e "\e[32mWebsite edited\e[0m"
        else
            echo -e "\e[31mInvalid website\e[0m"
        fi
    fi
}

check_websites() {
    echo "Checking if saved websites are online"
    cat ~/website_checker_list |
        while read in; do
            curl -fsS $in > /dev/null
            [[ $? = 0 ]] && result="\e[32mSUCCESS\e[0m" || result="\e[31mFAILED\e[0m"
            echo -e $in $result
        done
}

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
