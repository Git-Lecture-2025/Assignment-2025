#!/bin/bash

RED='\033[1;31m'
GREEN='\033[1;32m'
BLUE='\033[1;36m'
NC='\033[1;0m'
YELLOW='\033[1;33m'

echo -e "${YELLOW}"
echo "    __      __      __        __                           __                 ";
echo "   / /     / /___  / /_      / /___  ______  ___    ___   / /_   ____  _____  ";
echo "  / /     / // _ \/ __ \\   / / __ \/ __  // __ \ / __ \\/ __ \ / _ \\/ __  / ";
echo " / /__ __/ //  __/ /_/ //  / / / /_/ / /_/  /_/ // /_  _/  _/ //   __/ / /_/  ";
echo "/____//___/ \___/_____//__/\\____//_/    \\____/\\____//_/ \_\ \\___/_/       ";
echo ""
echo "                    Track and Manage Websites easily                          "
echo ""
echo -e "${NC}"

declare -A websites_list

options () {
	echo -e "${BLUE}To view all tracked websites    | Press(${GREEN}v${BLUE})" 
	echo -e "${BLUE}To add a new website to track   | Press(${GREEN}a${BLUE})"
	echo -e "${BLUE}To edit already tracked website | Press(${GREEN}e${BLUE})"
	echo -e "${BLUE}To delete a tracked website     | Press(${GREEN}d${BLUE})" 
	echo -e "${BLUE}To exit                         | Press(${GREEN}q${BLUE})"
	read option
	if [ "$option" = "v" ]; then
		echo -e "${YELLOW}"
		view
		echo -e "${NC}" 
	elif [ "$option" = "e" ]; then
                echo -e "${YELLOW}"
                edit
                echo -e "${NC}"
	elif [ "$option" = "d" ]; then
                echo -e "${YELLOW}"
                delete
                echo -e "${NC}"
	elif [ "$option" = "a" ]; then
		echo -e "${YELLOW}"
		read -p "Enter the website you want to check : " key
                if [[ -z "$key" ]]; then
                        echo "You can only check non-empty strings!"
                        options
                else
                        add $key
                        echo -e "${NC}"
                fi
	elif [ "$option" = "q" ]; then
		echo "Exiting"
		exit 0
	else
       		echo -e "${YELLOW}"
       		echo "Invalid option"
       		echo -e "${NC}"
       		options
	fi
}

view () {
        if [ "${#websites_list[@]}" -eq 0 ]; then
                echo "The list is empty"
                echo "You can check the status of websites by adding them to the list!"
                echo ""
        else
                for key in "${!websites_list[@]}"; do
                        if [[ "${websites_list[$key]}" == "accessible" ]]; then
                                echo -e "$key ${GREEN} ${websites_list[$key]} ${YELLOW}"
                        else
                                echo -e "$key ${RED} ${websites_list[$key]} ${YELLOW}"
                        fi
                done
                echo ""
                read -p "Would you like to view detailed status of the accessible websites? (y/n) " ans
                if [[ "$ans" == "y" ]]; then
                        read -p "Enter the website you want detailed status of : " status_key
                        echo -e "${NC}"
                        status $status_key
                else
                        options
                fi

        fi
        options
}

add () {
	if curl -Is "$1" >/dev/null 2>&1; then
		echo -e "${GREEN}$1 is accessible"
		websites_list[$1]="accessible"
		echo -e "Added $1 to the list of tracked websites"
  		echo -e "${YELLOW}"
                echo ""
                read -p "Would you like to view detailed status of this website? (y/n) " ans
                if [[ "$ans" == "y" ]]; then
                        echo -e "${NC}"
                        status $1
                else
                        options
                fi
	else
		echo -e "${RED}$1 is not accessible"
		websites_list[$1]="not accessible"
                echo -e "Added $1 to the list of tracked websites"
	fi
	options
}

edit () {
        read -p "Enter the website you want to edit : " key
        if [[ -z "$key" ]]; then
                echo "You can only edit non-empty strings!"
                options
                return 0
        fi
	if [[ -n "${websites_list[$key]}" ]]; then
		unset websites_list[$key]
                read -p "Enter the new website : " key_replace
                add $key_replace
	else
                echo "The website isn't being tracked currently."
	fi	
	options
}

delete () { 
	read -p "Enter the website you want to delete : " key
 	if [[ -z "$key" ]]; then
                echo "You can only delete non-empty strings!"
                options
                return 0
        fi
	if [[ -n "${websites_list[$key]}" ]]; then
		unset websites_list[$key]
                echo "Deleted."
        else
		echo "The website isnt being tracked currently."
	fi
	options
}

status () {
	if [[ "${websites_list[$1]}" == "accessible" ]]; then
		curl -I "$1"
	else
		echo "Either the website is unaccessible or not being tracked check the list again."
	fi
	options
}

options
