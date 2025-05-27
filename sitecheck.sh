#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
NC='\033[0m'

WEBSITES_FILE="$HOME/.sitecheker_websites.txt"
LOG_FILE="$HOME/.sitecheker_monitor.log"
SCRIPT_PATH="$(realpath "$0")"

touch "$WEBSITES_FILE"
touch "$LOG_FILE"

show_progress() {
    echo -e "will do something here..."
}

show_banner() {
    clear
    echo -e "${CYAN}"
    cat << "EOF"
╔═╗┬┌┬┐┌─┐╔═╗┬ ┬┌─┐┬┌─┌─┐┬─┐
╚═╗│ │ ├┤ ║  ├─┤├┤ ├┴┐├┤ ├┬┘
╚═╝┴ ┴ └─┘╚═╝┴ ┴└─┘┴ ┴└─┘┴└─
   Website Status Monitor
EOF
    echo -e "${NC}${CYAN}══════════════════════════════════${NC}"
}

show_menu() {
    show_banner
    echo -e "${WHITE}Main Menu${NC}"
    echo -e "${CYAN}1.${NC} Add Websites    ${CYAN}2.${NC} List Websites"
    echo -e "${CYAN}3.${NC} Remove Website  ${CYAN}4.${NC} Edit Website"
    echo -e "${CYAN}5.${NC} Check Status    ${CYAN}6.${NC} Setup Automation"
    echo -e "${CYAN}7.${NC} View Logs       ${CYAN}0.${NC} Exit"
    echo -en "${BLUE}Choice: ${NC}"
}

validate() {

    local url_regex='^https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)' # 
    local domain_regex='^[a-zA-Z0-9]([a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(\.[a-zA-Z0-9]([a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)+$'
    
    if [[ $1 =~ $url_regex ]]; then
        echo "$1"
        return 0
    elif [[ $1 =~ $domain_regex ]]; then
        echo "https://$1"
        return 0
    else
        return 1
    fi
}

add_websites() {
    show_banner
    echo -e "${GREEN}[+] Add Websites to Monitor${NC}"
    echo -e "${YELLOW}Enter websites separated by spaces:${NC}"
    echo -e "${CYAN}Examples: google.com https://github.com stackoverflow.com${NC}"
    echo -en "${BLUE}Websites: ${NC}"
    read -r input
    
    if [[ -z "$input" ]]; then
        echo -e "${RED}[!] No websites entered${NC}"
        read -p "Press Enter to continue..."
        return
    fi
    

    IFS=' ' read -ra websites <<< "$input"
    local valid=0
    local invalid=0
    
    for website in "${websites[@]}"; do
        website=$(echo "$website" | xargs)
        [[ -z "$website" ]] && continue

        if validated=$(validate "$website"); then
            if grep -Fxq "$validated" "$WEBSITES_FILE"; then
                echo -e "${YELLOW}[!] Already exists: $validated${NC}"
                continue
            fi
            
            echo "$validated" >> "$WEBSITES_FILE"
            echo -e "${GREEN}[+] Added: $validated${NC}"
            ((valid++))
        else
            echo -e "${RED}[!] Invalid URL format: $website${NC}"
            ((invalid++))
        fi
    done
    
    echo -e "${GREEN}[i] Added $valid new website(s)${NC}"
    echo -e "${YELLOW}[!] Skipped $invalid invalid URL(s)${NC}"
    read -p "Press Enter to continue..."
}

list() {
    if [[ ! -s "$WEBSITES_FILE" ]]; then
        echo -e "${RED}[!] No websites are being monitored!${NC}"
        read -p "Press Enter to continue..."
        return
    fi
    
    local no=1
    while IFS= read -r website; do
        echo -e "${CYAN}$no.${NC} $website"
        ((no++))
    done < "$WEBSITES_FILE"

    return $((no-1))
}

ls_websites() {
    show_banner
    echo -e "${GREEN}[i] Current Monitoring List${NC}"
    
    list
    read -p "Press Enter to continue..."
}

rm_website() {
    show_banner
    echo -e "${GREEN}[i] Remove Website${NC}"
    
    list
    local count=$?
    
    echo -en "${BLUE}Enter number to remove (0 to cancel): ${NC}"
    read -r choice
    
    [[ "$choice" == "0" ]] && return
    
    if ! [[ "$choice" =~ ^[0-9]+$ ]] || [[ "$choice" -lt 1 ]] || [[ "$choice" -gt $count ]]; then
        echo -e "${RED}[!] Invalid number!${NC}"
        read -p "Press Enter to continue..."
        return
    fi
    
    local rmed_website=$(sed -n "${choice}p" "$WEBSITES_FILE")
    sed -i "${choice}d" "$WEBSITES_FILE"
    echo -e "${GREEN}[i] Removed: $rmed_website${NC}"
    read -p "Press Enter to continue..."
}

edit_website() {
    show_banner
    echo -e "${GREEN}[i] Edit Website${NC}"
    
    list
    local count=$?
    
    echo -en "${BLUE}Enter number to edit (0 to cancel): ${NC}"
    read -r choice
    
    [[ "$choice" == "0" ]] && return
    
    if ! [[ "$choice" =~ ^[0-9]+$ ]] || [[ "$choice" -lt 1 ]] || [[ "$choice" -gt $count ]]; then
        echo -e "${RED}[!] Invalid number!${NC}"
        read -p "Press Enter to continue..."
        return
    fi
    
    local old_website=$(sed -n "${choice}p" "$WEBSITES_FILE")
    echo -e "${WHITE}Current: ${CYAN}$old_website${NC}"
    echo -en "${BLUE}New URL: ${NC}"
    read -r new_website
    
    [[ -z "$new_website" ]] && return
    
    if validated=$(validate "$new_website"); then
        sed -i "${choice}s|.*|$validated|" "$WEBSITES_FILE"
        echo -e "${GREEN}[i] Updated to: $validated${NC}"
    else
        echo -e "${RED}[!] Invalid URL format: $new_website${NC}"
    fi
    
    read -p "Press Enter to continue..."
}

check_website() {
    local website=$1
    local response=$(curl -fSsL -o /dev/null -w "%{http_code}" "$website" 2>/dev/null)
    
    if [[ -z "$response" ]]; then
        echo "ERROR:Connection Failed!"
    elif [[ "$response" -ge 200 && "$response" -lt 400 ]]; then
        echo "UP:$response"
    else
        echo "DOWN:$response"
    fi
}

check_status() {
    show_banner
    echo -e "${GREEN}[i] Checking Website Status${NC}"
    
    if [[ ! -s "$WEBSITES_FILE" ]]; then
        echo -e "${RED}[!] No websites are being monitored!${NC}"
        read -p "Press Enter to continue..."
        return
    fi
    
    local total=$(wc -l < "$WEBSITES_FILE")
    local current=0
    local up_count=0
    local down_count=0
    local error_count=0
    local temp_results=$(mktemp)
    
    echo -e "${WHITE}Checking $total website(s)...${NC}"
    
    while IFS= read -r website; do
        ((current++))
        show_progress $current $total
        local status=$(check_website "$website")
        echo "$website|$status" >> "$temp_results"
        sleep 0.1
    done < "$WEBSITES_FILE"
    
    echo
    echo -e "${WHITE}Status Report${NC}"
    printf "%-50s %-8s %-10s\n" "Website" "Code" "Status"
    echo "======================================================================"
    
    while IFS='|' read -r website status; do
        local status_code="${status#*:}"
        local status_type="${status%:*}"
        
        case "$status_type" in
            "UP")
                printf "%-50s %-8s ${GREEN}%-10s${NC}\n" "$website" "$status_code" "UP"
                ((up_count++))
                ;;
            "DOWN")
                printf "%-50s %-8s ${RED}%-10s${NC}\n" "$website" "$status_code" "DOWN"
                ((down_count++))
                ;;
            "ERROR")
                printf "%-50s %-8s ${YELLOW}%-10s${NC}\n" "$website" "N/A" "ERROR"
                ((error_count++))
                ;;
        esac
    done < "$temp_results"
    
    echo "======================================================================"
    echo -e "${GREEN}UP: $up_count${NC} | ${RED}DOWN: $down_count${NC} | ${YELLOW}ERRORS: $error_count${NC} | Total: $total"
    
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    echo "[$timestamp] UP: $up_count, DOWN: $down_count, ERRORS: $error_count, Total: $total" >> "$LOG_FILE"
    
    rm "$temp_results"
    read -p "Press Enter to continue..."
}

setup_cron() {
    show_banner
}

view_logs() {
    show_banner
}

main() {
    
    while true; do
        show_menu
        read -r choice
        
        case "$choice" in
            1) add_websites ;;
            2) ls_websites ;;
            3) rm_website ;;
            4) edit_website ;;
            5) check_status ;;
            6) setup_cron ;;
            7) view_logs ;;
            0) clear; exit 0 ;;
            *) echo -e "${RED}[!] Invalid choice${NC}"; sleep 1 ;;
        esac
    done
}

main