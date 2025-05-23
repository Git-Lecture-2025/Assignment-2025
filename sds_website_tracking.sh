#!/bin/bash

i=0
touch website.txt

y_n="1"
check="no"
while [ "$y_n" = "1" ]
do

    : > website.txt
    input=$(dialog --title "Website tracking" --menu "Tasks" 0 0 0 1 "Add" 2 "Remove" 3 "Edit" 3>&1 1>&2 2>&3 3>&-)
    if [ "$input" = "1" ]
    then
	    check="no"
	    for item in ${arr[@]}
            do
            	echo "$item" >> website.txt
            done
            dialog --title "Websites till now" --textbox website.txt 0 0
            while [ "$check" = "no" ]
	    do
		add=$(dialog --title "Adding a site" --inputbox "Please enter the site that you want to add" 0 0 3>&1 1>&2 2>&3 3>&-)
	    	if echo "$add" | grep -q "https://"
	    	then
			check="yes"
			arr[i]="$add"
			((i++))
			for item in ${arr[@]}
            		do
                		echo "$item" >> website.txt
            		done
	    	else
			check="no"
			dialog --title "Error" --msgbox "Please put a valid website" 0 0
	    	fi
	    done
    elif [ "$input" = "2" ]
    then
	    for item in ${arr[@]}
	    do
		echo "$item"
		echo "$item" >> website.txt
	    done
	    dialog --title "Websites till now" --textbox website.txt 0 0
            remove=$(dialog --title "Removing a site" --inputbox "Please enter the site number [starting from 0] that you want to remove" 0 0 3>&1 1>&2 2>&3 3>&-)
	    num=$((remove + 0))
            dialog --msgbox "$num"
	    unset "arr[$num]"
	    arr=(${arr[@]})
	    
	    for item in ${arr[@]}
	    do
        	echo "$item" > website.txt
	    done
    else
	    check="no"
	    for item in ${arr[@]}
            do
                echo "$item" >> website.txt
            done
	    dialog --title "Websites till now" --textbox website.txt 0 0
            editing_site=$(dialog --title "Editing a site" --inputbox "Please enter the number[Starting site is assumed as 0] of site that you want to edit" 0 0 3>&1 1>&2 2>&3 3>&-)
            edited_site=$(dialog --title "Editing a site" --inputbox "What do you want the site to be" 0 0 3>&1 1>&2 2>&3 3>&-)
            while [ "$check" = "no" ]
	    do
	    	if echo "$edited_site" | grep -q "https://"
	    	then
			check="yes"
			arr[editing_site]="$edited_site"
	    	else
			check="no"
                	dialog --title "Error" --msgbox "Please put a valid website" 0 0
                	edited_site=$(dialog --title "Editing a site" --inputbox "What do you want the site to be" 0 0 3>&1 1>&2 2>&3 3>&-)
            	fi
	    done
    fi
    y_n=$(dialog --title "Yes or No" --menu "Please put a yes or a no" 0 0 0 1 "yes" 2 "no" 3>&1 1>&2 2>&3 3>&-)
done
for item in ${arr[@]}
do
	echo "$item"
        echo "$item" > website.txt
done
for url in ${arr[@]}
do
	if curl --output /dev/null --silent --head --fail "$url"
	then
  		echo "URL exists: $url"
		curl -s -o /dev/null -w "Status Code of $url: %{http_code}\n" https://www.example.com >> website.txt
		curl -s -o /dev/null -w "Status Code of $url: %{http_code}\n" https://www.example.com
	else
  		echo "URL does not exist: $url"
		curl -s -o /dev/null -w "Status Code of $url: %{http_code}\n" https://www.example.com >> website txt
		curl -s -o /dev/null -w "Status Code of $url: %{http_code}\n" https://www.example.com
	fi
done