#!/bin/bash

WEBSITE_LIST=./.website_list.txt
if [ ! -f $WEBSITE_LIST ]; then
  touch $WEBSITE_LIST
fi

add_website(){
  tracking_list;
  echo "Enter the website you want to add to the tracking-list:"
  read website
  if grep -q "$website" $WEBSITE_LIST; then
    echo "Website already exists in the tracking-list."
  else
    echo "$website" >> $WEBSITE_LIST
    echo "Website added to the tracking-list."
  fi
  echo "--------------------------------"
  echo "Do you want to add another website? (y/n)"
  read answer
  if [ "$answer" == "y" ]; then
    add_website
  else
    echo "Returning to main menu."
  fi
  tracking_list;
}

remove_website(){
  tracking_list;
  echo "--------------------------------"
  echo "Enter the index number of the website you want to remove from the tracking-list:"
  read website_num
  if [ $website_num -lt 1 ] || [ $website_num -gt $(wc -l < $WEBSITE_LIST) ]; then
    echo "Invalid number. Please try again."
    remove_website  
  else
    sed -i "${website_num}d" $WEBSITE_LIST
    echo "Website removed from the tracking-list."
  fi
  echo "--------------------------------"
  echo "Do you want to remove another website? (y/n)"
  read answer
  if [ "$answer" == "y" ]; then
    remove_website
  else
    echo "Returning to main menu."
  fi
  tracking_list;
  return;
}

edit_website(){
  tracking_list;
  echo "--------------------------------"
  echo "Enter the index number of the website you want to edit in the tracking-list:"
  read website_num
  if [ $website_num -lt 1 ] || [ $website_num -gt $(wc -l < $WEBSITE_LIST) ]; then
    echo "Invalid number. Please try again."
    edit_website  
  else
    read -p "Enter the new website URL: " new_website
    sed -i "${website_num}s|.*|$new_website|" $WEBSITE_LIST
    echo "Tracking-list updated successfully."
  fi
  echo "--------------------------------"
  echo "Do you want to edit another website? (y/n)"
  read answer
  if [ "$answer" == "y" ]; then
    edit_website
  else
    echo "Returning to main menu."
  fi
  echo "-----------------------------------"
  echo "Current tracking-list:"
  i=1
  while IFS= read -r line
  do
    echo "$i.) $line"
    i=$((i+1))
  done < $WEBSITE_LIST
  sleep 1
  return;
}

check_status(){
  if [[ ! -f $WEBSITE_LIST || ! -s $WEBSITE_LIST ]]; then
    echo "No websites to check!"
    return
  fi
  echo "Checking website statuses..."
  echo "------------------------------"
  echo "Website URL                     Status"
  echo "------------------------------"
  while IFS= read -r website; do
    if [[ -z "$website" ]]; then
      continue
    fi
    status_code=$(curl -o /dev/null -s -w "%{http_code}" "$website")
    if [[ "$status_code" -eq 200 ]]; then
      status="Accessible"
    else
      status="Not Accessible ($status_code)"
    fi
    echo  "$website" "                       " "$status"
  done < $WEBSITE_LIST
  sleep 2
  return;
}

tracking_list(){
  echo "-----------------------------------"
  echo "Current tracking-list:"
  i=1
  while IFS= read -r line
  do
    echo "$i.) $line"
    i=$((i+1))
  done < $WEBSITE_LIST
  sleep 1
}


while [ true ]
do
  echo "-----------------------------------"
  echo "Welcome to the website tracker by Regie!"
  echo "-----------------------------------"
  echo "Choose from 1-5 to select what to do from the following:-"
  echo "1.) Add a website in the tracking-list"
  echo "2.) Remove a website from the tracking-list"
  echo "3.) Edit the tracking-list"
  echo "4.) Check status"
  echo "5.) Exit the program"

  read -p "Enter your choice number: "  choice
  if [ $choice -eq 1 ]
    then
	    add_website;
  fi
  if [ $choice -eq 2 ]
    then
      remove_website;
  fi
  if [ $choice -eq 3 ]
    then
        edit_website;
  fi
  if [ $choice -eq 4 ]
    then
        check_status;
  fi
  if [ $choice -eq 5 ]
    then
	echo "---------------------------"
        echo "Thanks for using the script"
	echo "---------------------------"
	exit
  fi
  if [ $choice -lt 1 ] || [ $choice -gt 5 ]
    then
        echo "Invalid choice. Please select a number between 1 and 5."
        sleep 0.5
        echo "-----------------------------------"
        echo "Returning to main menu."
        sleep 0.5
        echo "-----------------------------------"
  fi
done