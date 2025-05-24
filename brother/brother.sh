# #!/bin/bash
WEBSITE_FILE="websites.txt"
ROW=$(($(tput lines)/2 - 5))
COL=$(($(tput cols)/2 - 20))

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
    move_cursor $((ROW - 1)) $COL
    echo "$(tput setaf 3)Website Accessibility Checker"
    move_cursor $((ROW + 1)) $((COL + 3))

    echo "$(tput setaf 6)1. Add Website"
    move_cursor $((ROW + 2)) $((COL + 3))

    echo "$(tput setaf 6)2. Remove Website"
    move_cursor $((ROW + 3)) $((COL + 3))

    echo "$(tput setaf 6)3. Check Website Status"
    move_cursor $((ROW + 4)) $((COL + 3))

    echo "$(tput setaf 1)4. Exit"
    move_cursor $((ROW + 6)) $((COL + 3))

    echo "$(tput setaf 6)Enter your choice: "
    read -r choice
}

add_website() {
    clear_screen
    move_cursor $((ROW - 2)) $COL
    echo "$(tput setaf 6)Enter the website URL to add:"
    move_cursor $((ROW)) $COL
    read -r website
    echo "$website" >> "$WEBSITE_FILE"
    move_cursor $((ROW + 2)) $COL
    echo "$(tput setaf 2)Website added successfully!"
    move_cursor $((ROW + 3)) $COL
    echo "$(tput setaf 6)Press Enter to continue..."
    read -r
}

display_websites() {
    clear_screen
    move_cursor $((ROW - 3)) $COL
    echo "$(tput setaf 3)Websites in the track list:"
    move_cursor $((ROW - 1)) $COL
    echo "$(tput setaf 6)"
    awk -v col=$COL '{printf "\033[%d;%dH%s\n", NR + ENVIRON["ROW"] + 1, col, NR ". " $0}' "$WEBSITE_FILE"
    echo "$(tput sgr0)"
}

remove_website() {
    display_websites
    total_lines=$(wc -l < "$WEBSITE_FILE")
    move_cursor $((ROW + total_lines + 3)) $COL
    echo "$(tput setaf 6)Enter the number of the website to remove (or 0 to cancel): "
    read -r choice
    if [[ "$choice" -gt 0 ]]; then
        sed -i '' "${choice}d" "$WEBSITE_FILE"
        move_cursor $((ROW + total_lines + 5)) $COL
        echo "$(tput setaf 2)Website removed successfully!"
    fi
    move_cursor $((ROW + total_lines + 7)) $COL
    echo "$(tput setaf 6)Press Enter to continue..."
    read -r
}

check_status() {
    clear_screen
    move_cursor $((ROW - 3)) $COL
    echo "$(tput setaf 3)Checking website status..."
    move_cursor $((ROW - 1)) $COL
    echo "$(tput setaf 6)Website                                   Status"
    move_cursor $ROW $COL
    echo "$(tput setaf 6)--------------------------------------------------"
    line_num=$((ROW + 1))

    while IFS= read -r website; do
        move_cursor $line_num $COL
        echo "$(tput setaf 6)$website"
        if [[ "${website:0:4}" != "http" ]]; then
            website="https://$website"
        fi
        if curl -s --head --request GET "$website" | grep "200 OK" > /dev/null; then
            move_cursor $line_num $((COL + 40))
            echo "$(tput setaf 2)Accessible"
        elif curl -s --head --request GET "$website" | grep "301" > /dev/null; then
            move_cursor $line_num $((COL + 40))
            echo "$(tput setaf 3)Not Sure (301)"
        else
            move_cursor $line_num $((COL + 40))
            echo "$(tput setaf 1)Not Accessible"
        fi
        line_num=$((line_num + 1))
    done < "$WEBSITE_FILE"

    move_cursor $((line_num + 2)) $COL
    echo "$(tput setaf 6)Press Enter to continue..."
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
            move_cursor $((ROW + 8)) $COL
            echo "$(tput setaf 1)Invalid choice. Press Enter to continue..."
            read -r
            ;;
    esac
done

