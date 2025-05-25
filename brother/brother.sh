#!/bin/bash
WEBSITE_FILE="websites.txt"
ROW=$(($(tput lines)/2 - 5))
COL=$(($(tput cols)/2 - 20))
OS=$(uname)
if [[ $(tput lines) -lt 35 || $(tput cols) -lt 94 ]]; then
  echo "Screen resolution too small"
  exit
fi


if [[ ! -f "$WEBSITE_FILE" ]]; then
  touch "$WEBSITE_FILE"
  echo "Created website file"
fi


sed_i() {
    if [[ "$OS" == "Darwin" || "$OS" == "FreeBSD" ]]; then
        sed -i '' "$1" "$2"
    else
        sed -i "$1" "$2"
    fi
}


clear_screen() {
    tput clear
}

move_cursor() {
    tput cup "$1" "$2"
}
print_banner() {
    
    move_cursor $((ROW - 12)) $((COL -10))
    echo "$(tput setaf 5)"
    move_cursor $((ROW - 11)) $((COL -10))
    echo "██████╗ ██████╗  ██████╗ ████████╗██╗  ██╗███████╗██████╗ "
    move_cursor $((ROW - 10)) $((COL -10))
    echo "██╔══██╗██╔══██╗██╔═══██╗╚══██╔══╝██║  ██║██╔════╝██╔══██╗"
    move_cursor $((ROW - 9)) $((COL -10))
    echo "██████╔╝██████╔╝██║   ██║   ██║   ███████║█████╗  ██████╔╝"
    move_cursor $((ROW - 8)) $((COL -10))
    echo "██╔══██╗██╔══██╗██║   ██║   ██║   ██╔══██║██╔══╝  ██╔══██╗"
    move_cursor $((ROW - 7)) $((COL -10))
    echo "██████═╝██║  ██║╚██████╔╝   ██║   ██║  ██║███████╗██║  ██║"
    move_cursor $((ROW - 6)) $((COL -10))
    echo "╚═╝     ╚═╝  ╚═╝ ╚═════╝    ╚═╝   ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝"
    move_cursor $((ROW - 5)) $((COL -10))
    echo ""
}


show_menu() {
    clear_screen
    print_banner
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
    print_banner
    move_cursor $((ROW - 2)) $COL
    echo "$(tput setaf 6)Enter the website URL to add:"
    move_cursor $((ROW)) $COL
    read -r website
    if [[ "${website:0:4}" != "http" ]]; then
            website="https://$website"
    fi

    if [[ "${website:0:7}" == "http://" ]]; then
      website=$(sed 's#/.*##' <<< "${website:7}")
      website="http://$website"
    fi

    if [[ "${website:0:8}" == "https://" ]]; then
      website=$(sed 's#/.*##' <<< "${website:8}")
      website="https://$website"
    fi

    if [[ $(sed -n "/[^a-zA-Z0-9./:-]/p; /[[:space:]]/p; /^[^a-zA-Z0-9]/p; /[^a-zA-Z0-9]$/p" <<< "$website") != "" ]]; then
      move_cursor $((ROW + 3)) $COL
      echo "$(tput setaf 3)Incorrect domain name."
      sleep 2
      return
    fi

    isthere=false

    while IFS= read -r var; do
        if [[ "$var" == "$website" ]]; then
            isthere=true
            break
        fi
    done < "$WEBSITE_FILE"

    if [[ "$isthere" != "true" ]]; then
        echo "$website" >> "$WEBSITE_FILE"
        move_cursor $((ROW + 2)) $COL
        echo "$(tput setaf 2)"$website" added to the list successfully!"
    else
        move_cursor $((ROW + 2)) $COL
        echo "$(tput setaf 3)Website already exists!"
    fi

    move_cursor $((ROW + 3)) $COL
    echo "$(tput setaf 6)Press Enter to continue..."
    read -r
}

display_websites() {
    clear_screen
    print_banner
    move_cursor $((ROW - 3)) $COL
    if [[ $(wc -l < "$WEBSITE_FILE") -eq 0 ]]; then
      return
    fi

    echo "$(tput setaf 3)Websites in the track list:"
    echo "$(tput setaf 6)"
    index=1
    while IFS= read -r val; do
      move_cursor $((ROW + index)) $COL
      echo "$index $val"
      index=$((index+1))
    done<$WEBSITE_FILE
}

remove_website() {
    display_websites
    total_lines=$(wc -l < "$WEBSITE_FILE")
    move_cursor $((ROW + total_lines + 3)) $((COL-7))
    if [[ $(wc -l < "$WEBSITE_FILE") -eq 0 ]]; then
      move_cursor $((ROW)) $((COL-4))
      echo "$(tput setaf 3)Add some website first to remove them"
      sleep 2
      return
    fi
    echo "$(tput setaf 6)Enter the number of the website to remove (or 0 to cancel): "
    move_cursor $((ROW + total_lines + 5)) $((COL-7))
    read -r choice
    if [[ "$choice" -eq 0 ]]; then
      return
    elif [[ "$choice" -gt 0 ]] && [[ "$choice" -lt "$((total_lines+1))" ]]; then
        sed_i "${choice}d" "$WEBSITE_FILE"
        move_cursor $((ROW + total_lines + 5)) $COL
        echo "$(tput setaf 2)Website removed successfully!"
    else
        move_cursor $((ROW + total_lines + 7)) $COL
        echo "$(tput setaf 1) Invalid choice" 
    fi
    move_cursor $((ROW + total_lines + 9)) $COL
    echo "$(tput setaf 6)Press Enter to continue..."
    move_cursor $((ROW + total_lines + 11)) $COL
    read -r
}

check_status() {
    clear_screen
    print_banner
 if [[ $(wc -l < "$WEBSITE_FILE") -eq 0 ]]; then
   move_cursor $((ROW)) $((COL-4))
      echo "$(tput setaf 3)Add some website first to check there status"
      sleep 2
      return
    fi

    move_cursor $((ROW - 3)) $((COL - 5))
    echo "$(tput setaf 3)Checking website status..."
    move_cursor $((ROW - 1)) $((COL - 5))
    echo "$(tput setaf 6)Website                                   Status"
    move_cursor $ROW $((COL - 5))
    echo "$(tput setaf 6)--------------------------------------------------"
    line_num=$((ROW + 1))

    while IFS= read -r website; do
        move_cursor $line_num $((COL - 5))
        echo "$(tput setaf 6)${website:0:35}"
       
        status_code=$(curl -s -o /dev/null -w "%{http_code}" "$website")
        if [[ "$status_code" == 200 || "$status_code" == 300 || "$status_code" == 301 || "$status_code" == 302 ]]; then
            move_cursor $line_num $((COL + 35))
            echo "$(tput setaf 2)Website is up"
        else

            move_cursor $line_num $((COL + 35))
            echo "$(tput setaf 1)Not Accessible (status: $status_code)"
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
            move_cursor $((ROW + 9)) $COL
            read -r
            ;;
    esac
done

