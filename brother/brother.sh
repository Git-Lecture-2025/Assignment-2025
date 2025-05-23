#!/bin/bash
WEBSITE_FILE="websites.txt"

if [[ ! -f "$WEBSITE_FILE" ]]; then
  touch "$WEBSITE_FILE"
fi

clear_screen() {
    tput clear
}

move_cursor() {
    tput cup "$1" "$2"
}

show_menu() {
    clear_screen
    move_cursor 3 15
    echo "$(tput setaf 3)Website Accessibility Checker$(tput sgr0)"
    move_cursor 5 15
    echo "$(tput setaf 6)1. Add Website$(tput sgr0)"
    move_cursor 6 15
    echo "$(tput setaf 6)2. Remove Website$(tput sgr0)"
    move_cursor 7 15
    echo "$(tput setaf 6)3. Check Website Status$(tput sgr0)"
    move_cursor 8 15
    echo "$(tput setaf 1)4. Exit$(tput sgr0)"
    move_cursor 10 15
    echo "$(tput setaf 6)Enter your choice: $(tput sgr0)"
    read -r choice
}

add_website() {
    clear_screen
    move_cursor 3 15
    echo "$(tput setaf 6)Enter the website URL to add:$(tput sgr0)"
    move_cursor 7 15
    read -r website
    echo "$website" >> "$WEBSITE_FILE"
    move_cursor 9 15
    echo "$(tput setaf 2)Website added successfully!$(tput sgr0)"
    move_cursor 10 15
    echo "$(tput setaf 6)Press Enter to continue...$(tput sgr0)"
    read -r
}

display_websites() {
    clear_screen
    move_cursor 3 15
    echo "$(tput setaf 3)Websites in the track list:$(tput sgr0)"
    move_cursor 5 5
    echo "$(tput setaf 6)"
    awk '{print NR ". " $0}' "$WEBSITE_FILE"
    echo "$(tput sgr0)"
}

remove_website() {
    display_websites
    move_cursor $(($(wc -l < "$WEBSITE_FILE") + 7)) 15
    echo "$(tput setaf 6)Enter the number of the website to remove (or 0 to cancel): $(tput sgr0)"
    read -r choice
    if [[ "$choice" -gt 0 ]]; then
        sed -i '' "${choice}d" "$WEBSITE_FILE"
        move_cursor $(($(wc -l < "$WEBSITE_FILE") + 9)) 15
        echo "$(tput setaf 2)Website removed successfully!$(tput sgr0)"
    fi
    move_cursor $(($(wc -l < "$WEBSITE_FILE") + 11)) 15
    echo "$(tput setaf 6)Press Enter to continue...$(tput sgr0)"
    read -r
}

check_status() {
    clear_screen
    move_cursor 3 15
    echo "$(tput setaf 3)Checking website status...$(tput sgr0)"
    move_cursor 5 5
    echo "$(tput setaf 6)Website                                   Status$(tput sgr0)"
    move_cursor 6 5
    echo "$(tput setaf 6)--------------------------------------------------$(tput sgr0)"
    line_num=7

    while IFS= read -r website; do
        move_cursor $line_num 5
        echo -n "$(tput setaf 6)$website$(tput sgr0)"
        if [[ "${website:0:4}" != "http" ]]; then
            website="https://$website"
        fi
        if curl -s --head --request GET "$website" | grep "200 OK" > /dev/null; then
            move_cursor $line_num 45
            echo "$(tput setaf 2)Accessible$(tput sgr0)"
        elif curl -s --head --request GET "$website" | grep "301" > /dev/null; then
            move_cursor $line_num 45
            echo "$(tput setaf 3)Not Sure (301)$(tput sgr0)"
        else
            move_cursor $line_num 45
            echo "$(tput setaf 1)Not Accessible$(tput sgr0)"
        fi
        line_num=$((line_num + 1))
    done < "$WEBSITE_FILE"

    move_cursor $((line_num + 2)) 15
    echo "$(tput setaf 6)Press Enter to continue...$(tput sgr0)"
    read -r
}

while true; do
    show_menu
    case "$choice" in
        1) add_website ;;
        2) remove_website ;;
        3) check_status ;;
        4) clear_screen; exit 0 ;;
        *)
            move_cursor 13 15
            echo "$(tput setaf 1)Invalid choice. Press Enter to continue...$(tput sgr0)"
            read -r
            ;;
    esac
done

