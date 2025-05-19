#!/bin/bash

add_website() {
    echo -ne "Enter your website: "
    read website

    if [[ $website =~ ^https?:\/\/w?w?w?.+ ]]; then
        echo $website >> ~/website_checker_list
        echo "Website added"
    else
        echo "Input is not a website"
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
        echo "Invalid choice"
    else
        echo -ne "Are you sure? [y/N]? "
        read y
        if [[ "$y" = "y" ]]
        then
            sed -ie $n'd' ~/website_checker_list
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
        echo "Invalid choice"
    else
        entry=($(sed -n "${n}p;q" ~/website_checker_list))
        read -e -i $entry -p "Edit entry: " new_entry
        if [[ $new_entry =~ ^https?:\/\/w?w?w?.+ ]]; then
            sed -i "${n}s~.*~${new_entry}~" ~/website_checker_list
            echo "Website edited"
        else
            echo "Invalid website"
        fi
    fi
}

check_websites() {
    echo "Checking if saved websites are online"
    cat ~/website_checker_list |
        while read in; do
            curl -fsS $in > /dev/null
            [[ $? = 0 ]] && result="SUCCESS" || result="FAILED"
            echo $in $result
        done
}

