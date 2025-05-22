#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;36m'
NC='\033[0m'
YELLOW='\033[1;33m'

WEBSITE_LIST=./.website_list.txt
if [ ! -f $WEBSITE_LIST ]; then
  touch $WEBSITE_LIST
fi

add_website(){        
  while true; do
    tracking_list;
    echo -e "${YELLOW}"
    echo "[Enter "q" to quit and go back to the main menu]"
    echo -e "${BLUE}"
    echo -e "Enter the full website URL you want to add to the tracking-list:"
    read website
    if [[ "$website" == "q" ]]; then
      echo -e "Exiting edit mode.${NC}"
      break
    elif grep -q "$website" $WEBSITE_LIST; then
      echo -e "${RED}Website already exists in the tracking-list.${NC}"
    else
      echo "$website" >> $WEBSITE_LIST
      echo -e "${GREEN}Website added to the tracking-list.${NC}"
    fi
    echo -e "${BLUE}--------------------------------"
    echo -e "Do you want to add another website URL? (${GREEN}y/${RED}n${BLUE})"
    read answer
    if [ "$answer" != "y" ]; then
      echo -e "Returning to main menu.${NC}"
      break
    fi
  done
}


remove_website(){
  if [[ ! -f $WEBSITE_LIST || ! -s $WEBSITE_LIST ]]; then
    echo -e "${RED}"
    echo "No websites to check!"
    echo "Please add website URLs to the tracking-list first."
    echo -e "${NC}"
    sleep 1
    return
  fi

  while true; do
    tracking_list;
    echo -e "${BLUE}"
    echo "--------------------------------"
    echo -e "${YELLOW}"
    echo "[Enter "q" to quit and go back to the main menu]"
    echo -e "${BLUE}"
    echo "Enter the index number of the website URL you want to remove from the tracking-list:"
    read website_num
    total_lines=$(wc -l < "$WEBSITE_LIST")

    if [[ "$website_num" =~ ^[0-9]+$ ]] && [ "$website_num" -ge 1 ] && [ "$website_num" -le "$total_lines" ]; then 
      sed -i "${website_num}d" $WEBSITE_LIST
      echo -e "${GREEN}Website removed from the tracking-list.${NC}"
    elif [[ "$website_num" == "q" ]]; then
      echo -e "Exiting edit mode.${NC}"
      break
    else
      echo -e "${RED}Invalid number. Please try again.${NC}"
      continue
    fi

    echo -e "${BLUE}--------------------------------"
    echo -e "Do you want to remove another website URL? (${GREEN}y${BLUE}/${RED}n${BLUE})"
    read answer
    if [ "$answer" != "y" ]; then
      tracking_list;
      echo -e "Returning to main menu.${NC}"
      break
    fi
  done
}


edit_website(){
  if [[ ! -f $WEBSITE_LIST || ! -s $WEBSITE_LIST ]]; then
    echo -e "${RED}"
    echo "No websites to check!"
    echo "Please add website URLs to the tracking-list first."
    echo -e "${NC}"
    sleep 1
    return
  fi

  while true; do
    tracking_list;
    echo -e "${BLUE}"
    echo "--------------------------------"
    echo -e "${YELLOW}"
    echo "[Enter "q" to quit and go back to the main menu]"
    echo -e "${BLUE}"
    echo "Enter the index number of the website you want to edit in the tracking-list:"
    read website_num
    total_lines=$(wc -l < "$WEBSITE_LIST")
    if [[ "$website_num" =~ ^[0-9]+$ ]] && [ "$website_num" -ge 1 ] && [ "$website_num" -le "$total_lines" ]; then
      echo -e "${GREEN}"
      read -p "Enter the new website URL: " new_website
      sed -i "${website_num}s|.*|$new_website|" $WEBSITE_LIST
      echo -e "Tracking-list updated successfully.${NC}"
    elif [[ "$website_num" == "q" ]]; then
      echo -e "Exiting edit mode.${NC}"
      break
    else
      echo -e "${RED}Invalid number. Please try again.${NC}"
      continue
    fi

    echo -e "${BLUE}--------------------------------"
    echo -e "Do you want to edit another website URL? (${GREEN}y${BLUE}/${RED}n${BLUE})"
    read answer
    if [ "$answer" != "y" ]; then
      tracking_list;
      echo -e "Returning to main menu.${NC}"
      break
    fi
  done
}


check_status(){
  if [[ ! -f $WEBSITE_LIST || ! -s $WEBSITE_LIST ]]; then
    echo -e "${RED}"
    echo "No websites to check!"
    echo "Please add website URLs to the tracking-list first."
    echo -e "${NC}"
    sleep 1
    return
  fi
  echo -e "${BLUE}"
  echo "Checking website statuses..."
  echo "------------------------------"
  echo -e "Website URL\t\t\t\tStatus"
  echo "------------------------------"
  while IFS= read -r website; do
    if [[ -z "$website" ]]; then
      continue
    fi
    status_code=$(curl -o /dev/null -s -w "%{http_code}" "$website")
    if [[ "$status_code" -eq 200 ]]; then
      echo -e "${GREEN}"
      status="Accessible"
    else
      echo -e "${RED}"
      status="Not Accessible ($status_code)"
    fi
    echo -e "$website\t\t\t\t$status"
  done < $WEBSITE_LIST
  sleep 2
  echo -e "${NC}"
  return;
}

tracking_list(){
  echo -e "${GREEN}"
  echo "-----------------------------------"
  echo "Current tracking-list:"
  i=1
  while IFS= read -r line
  do
    echo "$i.) $line"
    i=$((i+1))
  done < $WEBSITE_LIST
  sleep 1
  echo -e "${NC}"
}


while [ true ]
do
  echo -e "${BLUE}"
  echo "█     █ ███  ███  ███  █  ███  ███     ███  ███   ██  ███ █  █ ███ ███ "
  echo "█     █ █    █  █ █    █   █   █        █   █  █ █  █ █   █ █  █   █  █"
  echo "█  █  █ ███  ███  ███  █   █   ███      █   ███  ████ █   ██   ███ ███ "
  echo "█ █ █ █ █    █  █   █  █   █   █        █   █  █ █  █ █   █ █  █   █  █"
  echo " █   █  ███  ███  ███  █   █   ███      █   █  █ █  █ ███ █  █ ███ █  █"
  echo -e "${RED}"
  echo -e "\e[1m \t\t\t\t\t\tby Regie\e[0m"
  echo -e "${NC}"
  echo -e "${YELLOW}-----------------------------------"
  echo -e "Choose from 1-5 to select what to do from the following:-"
  echo -e "${YELLOW}-----------------------------------"
  echo -e "${BLUE}1.)${NC} Add a website in the tracking-list"
  echo -e "${BLUE}2.)${NC} Remove a website from the tracking-list"
  echo -e "${BLUE}3.)${NC} Edit the tracking-list"
  echo -e "${BLUE}4.)${NC} Check status"
  echo -e "${BLUE}5.)${NC} Exit the program"

  echo -e "${GREEN}"
  read -p "Enter your choice number and Press Enter: "  choice
  echo -e "${NC}"
  if [[ "$choice" =~ ^[0-9]+$ ]]; then
  if [ $choice -eq 1 ]
    then
	    add_website;
  elif [ $choice -eq 2 ]
    then
      remove_website;
  elif [ $choice -eq 3 ]
    then
        edit_website;
  elif [ $choice -eq 4 ]
    then
        check_status;
  elif [ $choice -eq 5 ]
    then
  echo -e "${YELLOW}"
	echo "---------------------------"
        echo "Thanks for using the script"
	echo "---------------------------"
  echo -e "${NC}"
  sleep 1
	exit
  fi
  else
        echo -e "${RED}"
        echo "Invalid choice. Please select a number between 1 and 5."
        sleep 0.5
        echo -e "${NC}"
        echo -e "${YELLOW}Please try again."
        echo -e "${NC}"
        sleep 0.5
  fi
done