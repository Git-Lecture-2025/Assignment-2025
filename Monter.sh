#!/bin/bash

Website_file=web.log

# Color codes
BLACK="\e[30m"
LIGHTRED="\e[91m"
RED="\e[31m"
GREEN="\e[32m"
BLUE="\e[34m"
LIGHTGREEN="\e[92m"
YELLOW="\e[33m"
LIGHTBLUE="\e[94m"
MAGENTA="\e[35m"
LIGHTCYAN="\e[96m"
WHITE="\e[37m"
LIGHTGRAYBG="\e[47m"
GRAY="\e[97m"

END="\e[0m"
BOLD="\e[1m"
FAINT="\e[2m"
ITALIC="\e[3m"
UNDER="\e[4m"

list_website() {
    if [ ! -s $Website_file ]; then
        echo -e "${FAINT}${RED}Track list is empty.${END}"
        sleep 1
        return
    fi

    i=1
    echo -e "${YELLOW}------------------------------------------------------${END}"
    echo -e "${BOLD}${YELLOW}Websites being tracked:- ${END}"

    while IFS= read -r line; do
        echo -e "${GREEN}$i ${LIGHTBLUE}$line${END}"
        ((i++))
    done < $Website_file

    echo -e "${YELLOW}------------------------------------------------------${END}"
    sleep 1
}

add_website() {
    echo " "
    echo -e "${YELLOW}Enter a website to track (\"q\" to exit):${END}"
    read -r website
    website=$(normalize_url "$website")

    if grep -q -s -w "$website" $Website_file; then
        echo -e "${FAINT}${YELLOW}Website already exists.${END}"
    elif [[ "$website" == "q" ]]; then
        echo -e "${FAINT}${WHITE}Exiting...${END}"
        sleep 1
        return
    else
        echo "$website" >> $Website_file
        if [ $? -eq 0 ]; then
            echo -e "${GREEN}Website added successfully${END}"
        else
            echo -e "${RED}Error occurred. Please try again${END}"
        fi
    fi

    echo " "
    sleep 1
}

normalize_url() {
    url="$1"
    url=$(printf "%s" "$url" | tr '[:upper:]' '[:lower:]')
    url=${url#http://} 
    url=${url#https://}
    url=${url#www.}     
    url=${url%%/*}  
    url=${url%%\?*} 
    url=${url%%\#*}
    printf "%s\n" "$url"
}

remove_website() {
    list_website
    echo " "

    if [ ! -s $Website_file ]; then
        echo -e "${RED}Please first add some website(s) to the track list.${END}"
        sleep 1
        return
    fi

    line_count=$(wc -l < $Website_file)
    echo -e "${LIGHTCYAN}Track file has ${GREEN}$line_count ${LIGHTCYAN}lines.${END}"
    echo -e "${YELLOW}Enter ${GREEN}index (line number) ${YELLOW}of the website to be removed (\"q\" to exit):${END}"
    read -r website

    if [[ "$website" == "q" ]]; then
        echo -e "${FAINT}${LIGHTGRAY}Exiting...${END}"
        sleep 1
        return
    elif [ "$website" -gt 0 ] && [ "$website" -le "$line_count" ]; then
        sed -i "${website}d" $Website_file
        echo -e "${ITALIC}${GREEN}Website removed from track list.${END}"
    else
        echo -e "${BOLD}${RED}Try to choose correct options next time.${END}"
    fi

    echo " "
    sleep 1
}

edit_website() {
    list_website
    echo " "

    if [ ! -s $Website_file ]; then
        echo -e "${RED}Please first add some website(s) to the track list.${END}"
        sleep 1
        return
    fi

    line_count=$(wc -l < $Website_file)
    echo -e "${LIGHTCYAN}Track file has ${GREEN}$line_count ${LIGHTCYAN}lines.${END}"
    var=1

    while [ $var -eq 1 ]; do
        echo -e "${YELLOW}Enter ${GREEN}index (line number) ${YELLOW}of the website to be edited (\"q\" to exit):${END}"
        read -r websiteOld
        websiteOld=$(normalize_url "$websiteOld")

        if [[ "$websiteOld" == "q" ]]; then
            echo -e "${FAINT}${WHITE}Exiting...${END}"
            sleep 1
            return
        elif [ "$websiteOld" -gt 0 ] && [ "$websiteOld" -le "$line_count" ]; then
            echo -e "${YELLOW}Enter new website name(\"q\" to abort):${END}"
            read -r websiteNew
            websiteNew=$(normalize_url "$websiteNew")

            if [[ "$websiteNew" == "q" ]]; then
                echo -e "${FAINT}${RED}Aborting...${END}"
                sleep 1
                return
            elif grep -q -s -w "$websiteNew" $Website_file; then
                echo -e "${LIGHTBLUE}$websiteNew ${GRAY}already exists in track list."
                echo -e "No change occurred, try again.${END}"
                return
            else
                sed -i "${websiteOld}c\\${websiteNew}" $Website_file
                if [ $? -eq 0 ]; then
                    echo -e "${GREEN}Edit successful.${END}"
                else
                    echo -e "${RED}Error occurred. Exiting...${END}"
                    sleep 1
                    return
                fi
            fi
            var=0
        else
            echo -e "${BOLD}${RED}Next time choose correct options.${END}"
        fi
    done

    echo " "
    sleep 1
}

check_status() {
    echo -e "${YELLOW}----------------------------------------------------------------------------------------------------${END}"

    if [ ! -s $Website_file ]; then
        echo -e "${ITALIC}${RED} Nothing to track.${END}"
        sleep 1
        return
    fi

    i=1
    printf "${LIGHTGRAYBG}${BOLD}${BLACK}%-8s %-60s %-15s %-40s${END}\n" "Index" "| Website url" "| Status code" "| Website status"
    echo -e "${GRAY}---------------------------------------------------------------------------------------------------${END}"

    while IFS= read -r line; do
        status_code=$(curl -L -I -o /dev/null -s -w "%{http_code}" "$line")

        if [ "$status_code" -ge 200 ] && [ "$status_code" -lt 300 ]; then
            printf "${GREEN}%-8s ${LIGHTBLUE}%-60s ${YELLOW}%-15s ${LIGHTGREEN}%-40s${END}\n" "$i" "| $line" "| $status_code" "| Accessible"
        elif [ "$status_code" -ge 300 ] && [ "$status_code" -lt 400 ]; then
            printf "${GREEN}%-8s ${LIGHTBLUE}%-60s ${YELLOW}%-15s ${LIGHTRED}%-40s${END}\n" "$i" "| $line" "| $status_code" "| Not Accessible (Redirected)"
        else
            printf "${GREEN}%-8s ${LIGHTBLUE}%-60s ${YELLOW}%-15s ${RED}%-40s${END}\n" "$i" "| $line" "| $status_code" "| Not Accessible (Error)"
        fi

        ((i++))
    done < $Website_file

    echo -e "${YELLOW}--------------------------------------------------------------------------------------------------${END}"
    sleep 1
}

choicer() {
    while true; do
        echo -e "${MAGENTA}------------------------------------------------------${END}"
        echo -e "${MAGENTA} 0. List the websites in track list${END}"
        echo -e "${GREEN} 1. Add a website to the track list${END}"
        echo -e "${RED} 2. Remove a website from the track list${END}"
        echo -e "${LIGHTCYAN} 3. Edit a website in the track list${END}"
        echo -e "${BLUE} 4. Check status of websites in track list${END}"
        echo -e "${WHITE} 5. End the Script${END}"
        echo -e "${YELLOW} Enter your choice (0-5):${END}"
        read -r choice

        case $choice in
            0) list_website ;;
            1) add_website ;;
            2) remove_website ;;
            3) edit_website ;;
            4) check_status ;;
            5)
                echo -e "${BLUE}Thank you for using ${MAGENTA}Monter${END}"
                echo -e "${FAINT}${BLUE}Ending script...${END}"
                sleep 1
                exit 0
                ;;
            *) echo -e "${LIGHTRED}Please enter digit of choice 0 through 5 only.${END}" ;;
        esac
    done
}

main() {
    echo " "
    echo -e "${MAGENTA}---------------------------------------------------------------------------------------------------${END}"
    echo -e "${MAGENTA}---------------------------------------------------------------------------------------------------${END}"
    echo " "
    echo -e "${MAGENTA}"
    echo -e "   *         *      ******      *      **   **********   ********    ******     "
    echo -e "   **       **     ********     **     **    ********    ********   ********    "
    echo -e "   ***     ***    **      **    ***    **       **       **         **    **    "
    echo -e "   ****   ****   **        **   ****   **       **       ******     **    **    "
    echo -e "   ** ** ** **   **        **   ** **  **       **       ******     ***  **     "
    echo -e "   **  ***  **   **        **   **  ** **       **       **         ******      "
    echo -e "   **       **    **      **    **   ****       **       **         **   **     "
    echo -e "   **       **     ********     **    ***       **       ********   **    **    "
    echo -e "   **       **      ******      **     **       **       ********   **     **   "
    echo -e "${END}"
    echo " "
    echo -e "${BOLD}${BLUE}Welcome to Monter: the website status checker${END}"
    echo " "

    choicer
}

main
