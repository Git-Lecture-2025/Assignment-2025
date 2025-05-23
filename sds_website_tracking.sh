#!/bin/bash

i=0
touch website.txt

y_n="1"
while [ "$y_n" = "1" ]
do

    : > website.txt
    input=$(dialog --title "Website tracking" --menu "Tasks" 0 0 0 1 "Add" 2 "Remove" 3 "Edit" 3>&1 1>&2 2>&3 3>&-)
    dialog --title "The option you chose is" --msgbox "$input" 0 0
    if [ "$input" = "1" ]
    then
	    for item in ${arr[@]}
            do
                echo "$item" >> website.txt
            done
            dialog --title "Websites till now" --textbox website.txt 0 0
            add=$(dialog --title "Adding a site" --inputbox "Please enter the site that you want to add" 0 0 3>&1 1>&2 2>&3 3>&-)
            arr[i]="$add"
	    ((i++))
    elif [ "$input" = "2" ]
    then
	    for item in ${arr[@]}
	    do
		echo "$item" >> website.txt
	    done
	    dialog --title "Websites till now" --textbox website.txt 0 0
            remove=$(dialog --title "Removing a site" --inputbox "Please enter the site number[Assuming that it is starting from 0]  that you want to remove" 0 0 3>&1 1>&2 2>&3 3>&-)
            unset arr[remove]

    else
	    for item in ${arr[@]}
            do
                echo "$item" >> website.txt
            done
	    dialog --title "Websites till now" --textbox website.txt 0 0
            editing_site=$(dialog --title "Editing a site" --inputbox "Please enter the number[Starting site is assumed as 0] of site that you want to edit" 0 0 3>&1 1>&2 2>&3 3>&-)
            edited_site=$(dialog --title "Editing a site" --inputbox "What do you want the site to be" 0 0 3>&1 1>&2 2>&3 3>&-)
            arr[editing_site]="$edited_site"
    fi
    y_n=$(dialog --title "Yes or No" --menu "Please put a yes or a no" 0 0 0 1 "yes" 2 "no" 3>&1 1>&2 2>&3 3>&-)
    dialog --title "The option you chose is" --msgbox "$y_n" 0 0
done
for item in ${arr[@]}
do
	echo "$item"
        echo "$item" >> website.txt
done
for url in ${arr[@]}
do
	if curl --output /dev/null --silent --head --fail "$url"
	then
  		echo "URL exists: $url"
		curl -s -o /dev/null -w "Status Code of $url: %{http_code}\n" https://www.example.com >> website.txt
	else
  		echo "URL does not exist: $url"
		curl -s -o /dev/null -w "Status Code of $url: %{http_code}\n" https://www.example.com >> website txt
	fi
done
