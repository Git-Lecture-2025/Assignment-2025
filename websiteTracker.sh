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

current_path=$(pwd)

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
  		store_list
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
                        echo -e "$key ${GREEN} ${websites_list[$key]} ${YELLOW}"
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
	if curl -ILs "$1" >/dev/null 2>&1; then
		echo -e "${GREEN}$1 is accessible"
		websites_list[$1]=$(curl -s -o /dev/null -I -w "%{http_code}" "$1")
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
		echo -e "${RED}$1 is not a valid website"
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
	if [[ -n "${websites_list[$1]}" ]]; then
		curl -IL "$1"
        elif curl -ILs "$1" >/dev/null 2>&1; then
                echo "The website isn't being tracked, you can only view detailed status of tracked accessible websites."
        else
		echo "The input is not a valid website!"	
 	echo ""
	fi
	options
}

store_list () {
        list_string=""
        for key in "${!websites_list[@]}"; do
                list_string+="$key=${websites_list[$key]} "
        done
        list_string="${list_string% }"
        echo "$list_string" > websites_list.txt
}

retrieve_list () {
        retrieved_string=$(cat websites_list.txt)
        for pair in $retrieved_string; do
                if [[ "$pair" =~ ^([^=]+)=(.*)$ ]]; then
                        key="${BASH_REMATCH[1]}"
                        value="${BASH_REMATCH[2]}"
                        websites_list["$key"]="$value"
                fi
        done
}

if [ -f "$current_path/websites_list.txt" ]; then
        declare -A websites_list
        retrieve_list
else
        touch websites_list.txt
        declare -A websites_list
fi

options
