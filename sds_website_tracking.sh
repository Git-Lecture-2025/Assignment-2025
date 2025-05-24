#!/bin/bash

i=0
touch website.txt

if [[ "$OSTYPE" == "linux-gnu"* ]]
then
        sudo apt-get update
        sudo apt-get install dialog
elif [[ "$OSTYPE" == "darwin"* ]]
then
        brew install dialog
elif [[ "$OSTYPE" == "win32" ]]
then
        sudo apt-get update
        sudo apt-get install dialog
elif [[ "$OSTYPE" == "msys" ]]
then
        sudo apt-get update
        sudo apt-get install dialog
fi
y_n="1"
check="no"
while [ "$y_n" = "1" ]
do

    : > website.txt
    input=$(dialog --title "Website tracking" --menu "Tasks" 0 0 0 1 "Add" 2 "Remove" 3 "Status" 4 "Edit" 3>&1 1>&2 2>&3 3>&-)
    if [ "$input" = "1" ]
    then
	    check="no"
	    for item in ${arr[@]}
        do
            echo "$item" >> website.txt
        done
        dialog --title "Websites till now" --msgbox "$(cat website.txt)" 0 0 --ok-label "Next"

        while [ "$check" = "no" ]
	    do
		    add=$(dialog --title "Adding a site" --inputbox "Please enter the site that you want to add" 0 0 3>&1 1>&2 2>&3 3>&-)
            # sc=$(curl -s -o /dev/null -w "%{http_code} ${add}")
            if [ $? -eq 1 ]
            then
                dialog --title "Cancel" --msgbox "You will meet a yes or no question where if you don't want to add , remove or edit anything then you can press no" 0 0
                break
            else

                status_code=$(curl -L --write-out %{http_code} --silent --output /dev/null "$add")
                if [ $status_code -eq 200 ]
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
            fi
	    done
    elif [ "$input" = "2" ]
    then
        length=${#arr[@]}
        if [ $length -ne 0 ]
        then
            for item in ${arr[@]}
            do
                echo "$item"
                echo "$item" >> website.txt
            done
            dialog --title "Websites till now" --msgbox "$(cat website.txt)" 0 0 --ok-label "Next"
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
            dialog --title "Error" --msgbox "Please add a site first. You will be meeting with a yes or no first so put a yes and then click add a site" 0 0
            input="1"
        fi
    elif [ "$input" = "3" ]
    then
        length=${#arr[@]}
        if [ $length -ne 0 ]
        then
            for url in ${arr[@]}
            do
                if curl -L --output /dev/null --silent --head --fail "$url"
                then
                    echo "URL exists: $url"
                    curl -L -s -o /dev/null -w "Status Code of $url: %{http_code}\n" https://www.example.com >> website.txt
                    # curl -s -o /dev/null -w "Status Code of $url: %{http_code}\n" https://www.example.com
                else
                    echo "URL does not exist: $url"
                    curl -L -s -o /dev/null -w "Status Code of $url: %{http_code}\n" https://www.example.com >> website.txt
                    # curl -s -o /dev/null -w "Status Code of $url: %{http_code}\n" https://www.example.com
                fi
            done
        dialog --title status --textbox website.txt 0 0
        else
            dialog --title "Error" --msgbox "Please add a site first. You will be meeting with a yes or no first so put a yes and then click add a site" 0 0
            input="1"
        fi
    else
        length=${#arr[@]}
        if [ $length -ne 0 ]
            then
            check="no"
            for item in ${arr[@]}
                do
                    echo "$item" >> website.txt
                done
            dialog --title "Websites till now" --msgbox "$(cat website.txt)" 0 0 --ok-label "Next"
            editing_site=$(dialog --title "Editing a site" --inputbox "Please enter the number[Starting site is assumed as 0] of site that you want to edit" 0 0 3>&1 1>&2 2>&3 3>&-)
            editing_site_exit_code=$?
            editing_site_number=$((editing_site + 0))
            while [[ "$editing_site_number" -ge "$length" || "$editing_site_number" -lt 0 ]]
            do
                dialog --title "Error" --msgbox "Please put a valid number" 0 0
                editing_site=$(dialog --title "Editing a site" --inputbox "Please enter the number[Starting site is assumed as 0] of site that you want to edit" 0 0 3>&1 1>&2 2>&3 3>&-)
                editing_site_number=$((editing_site + 0))
            done
            if [[ "$editing_site_exit_code" -eq 1 ]]
            then
                dialog --title "Cancel" --msgbox "You will meet a yes or no question where if you don't want to add , remove or edit anything then you can press no" 0 0
                break
            else
                edited_site=$(dialog --title "Editing a site" --inputbox "What do you want the site to be from ${arr[editing_site]}" 0 0 3>&1 1>&2 2>&3 3>&-)
                edited_site_exit_code=$?
                while [ "$check" = "no" ]
                do
                    if [[ "$edited_site_exit_code" -eq 1 ]]
                    then
                        dialog --title "Cancel" --msgbox "You will meet a yes or no question where if you don't want to add , remove or edit anything then you can press no" 0 0
                        break
                    else
                        status_code=$(curl -L --write-out %{http_code} --silent --output /dev/null "$edited_site")
                        if [ $status_code -eq 200 ]
                        then
                            check="yes"
                            arr[editing_site]="$edited_site"
                        else
                            check="no"
                            dialog --title "Error" --msgbox "Please put a valid website" 0 0
                            edited_site=$(dialog --title "Editing a site" --inputbox "What do you want the site to be" 0 0 3>&1 1>&2 2>&3 3>&-)
                        fi
                    fi
                done
            fi
        else
            dialog --title "Error" --msgbox "Please add a site first. You will be meeting with a yes or no first so put a yes and then click add a site" 0 0
            input="1"
        fi
    fi
    y_n=$(dialog --title "Yes or No" --menu "Please put a yes or a no" 0 0 0 1 "work" 2 "quit" 3>&1 1>&2 2>&3 3>&-)
    if [ $? -eq 1 ]
    then
        y_n="0"
    fi
done
for item in ${arr[@]}
do
	echo "$item"
    echo "$item" > website.txt
done
for url in ${arr[@]}
do
	if curl -L --output /dev/null --silent --head --fail "$url"
	then
  		echo "URL exists: $url"
		curl -L -s -o /dev/null -w "Status Code of $url: %{http_code}\n" https://www.example.com >> website.txt
		curl -L -s -o /dev/null -w "Status Code of $url: %{http_code}\n" https://www.example.com
	else
  		echo "URL does not exist: $url"
		curl -L -s -o /dev/null -w "Status Code of $url: %{http_code}\n" https://www.example.com >> website.txt
		curl -L -s -o /dev/null -w "Status Code of $url: %{http_code}\n" https://www.example.com
	fi
done