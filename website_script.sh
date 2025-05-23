#!/bin/bash
theFile="websites.txt"
green='\033[0;32m'
red='\033[0;31m'
blue='\033[0;34m'
briyellow='\033[0;93m'
brired='\033[0;91m'
magenta='\033[0;35m'
brigreen='\033[0;92m'
clear='\033[0m'
thumbsUp='👍'
thumbsDown='👎'
skull='💀'
byebye='👋'
touch "$theFile"
# Can't use unicode in emojis. Why do they exist then?

showMenu() {
    echo -e "---------- ${green}Website Tracker${clear} ----------"
    echo -e "1. For ${brigreen}ADD WEBSITE${clear} - Enter 1"
    echo -e "2. For ${magenta}LIST WEBSITE${clear} - Enter 2"
    echo -e "3. For ${brired}REMOVE WEBSITE${clear} - Enter 3"
    echo -e "4. For ${briyellow}EDIT WEBSITE${clear} - Enter 4"
    echo -e "5. For ${green}CHECK WEBSITE STATUS${clear} - Enter 5"
    echo -e "6. For ${red}EXIT${clear} - Enter 6"
    echo "-------------------------------------"
}

addWebsite() {
    echo " "
    echo -e "${brigreen}ADD WEBSITE${clear}"
    echo -e "If you have ${briyellow}arrived here accidentally${clear}, press ${brigreen}-1${clear} to go back"
    echo -n "Enter the website URL to be added: "
    read url
    if [[ "$url" == "-1" ]]; then
        echo -e "Alright! ${magenta}Back to Home${clear}"
    elif [[ "$url" == "" ]]; then
        echo -e "${brired}Empty Input${clear}! Try again"
    else
        echo "$url" >> "$theFile"
        echo -e "${green}Website added to the list.${clear}"
    fi
}

listWebsite() {
    cat "$theFile" | while read line; do echo -e "${blue}$line${clear}"; 
    done
}

removeWebsite() {
    echo "Websites in the List:"
    nl -n ln -s '. ' -w 1 "$theFile" | while read -r num url; do
        echo -e "${num} ${blue}${url}${clear}"
    done
    echo " "
    echo -e "${brired}REMOVE WEBSITE${clear}"
    echo -e "If you have ${briyellow}arrived here accidentally${clear}, press ${brigreen}-1${clear} to go back"
    echo -n "Enter the line number to be removed: "
    read lineNum
    lines=$(wc -l < ${theFile})
    if [[ $lineNum -le $lines && $lineNum -gt 0 ]]; then
        echo -n -e "Are you sure? ${skull} [Y/n]: "
        read y
        if [[ -z "$y" || "${y}" == "y" || "${y}" == "Y" ]]; then
            echo -e "Alright. Goodbye URL no.${lineNum} ${byebye}"
            sed -i "${lineNum}d" "$theFile"
            echo -e "${red}Website removed from the list.${clear}"
        elif [[ "$y" == "n" || "$y" == "N" ]]; then
            echo -e "${briyellow}You pressed no. Good thing I asked you before the data went whoosh!${clear}"
        else
            echo -e "You pressed something else entirely. ${brired}Not ready it seems${clear}. Go back Home."
        fi
    elif [[ $lineNum -eq "-1" ]]; then
        echo -e "Alright! ${magenta}Back to Home${clear}"
    else
        echo -e "${brired}Invalid Input${clear}! Please try again."
    fi
}

editWebsite() {
    echo "Websites in the List:"
    nl -n ln -s '. ' -w 1 "$theFile" | while read -r num url; do
        echo -e "${green}${num}${clear} ${blue}${url}${clear}"
    done
    echo " "
    echo -e "${briyellow}EDIT WEBSITE${clear}"
    echo -e "If you have ${briyellow}arrived here accidentally${clear}, press ${brigreen}-1${clear} to go back"
    echo -n "Enter the line number to be edited: "
    read num
    lines=$(wc -l < ${theFile})
    if [[ $num -le $lines && $num -gt 0 ]]; then
        echo -n "Enter the new website URL: "
        read newURL
        if [[ "$newURL" == "" ]]; then
            echo -e "${brired}Empty Input${clear}! Try again"
        else
            sed -i "${num}s#.*#$newURL#" "$theFile"
            echo -e "${green}Website edited into the list.${clear}"
        fi
    elif [[ $num -eq "-1" ]]; then
        echo -e "Alright! ${magenta}Back to Home${clear}"
    else
        echo -e "${brired}Invalid Input${clear}! Please try again."
    fi 
}

playSound() {
    while true; do
        play -n synth 0.2 sine C > /dev/null 2>&1 &
        sleep 0.25
        play -n synth 0.2 sine E > /dev/null 2>&1 &
        sleep 0.25
        play -n synth 0.2 sine G > /dev/null 2>&1 &
        sleep 0.25
        play -n synth 0.2 sine A > /dev/null 2>&1 &
        sleep 0.25
        play -n synth 0.2 sine G > /dev/null 2>&1 &
        sleep 0.25
        play -n synth 0.2 sine E > /dev/null 2>&1 &
        sleep 0.25
        play -n synth 0.2 sine C > /dev/null 2>&1 &
        sleep 0.25
    done
}

checkWebsite() {
    echo -e "${briyellow}Checking websites...${clear}"
    echo "---------------------------------------------"
    echo "Website  -->  Status"
    echo "---------------------------------------------"
    if ! which sox > /dev/null; then
        echo -e "${brigreen}SoX${clear} is ${brired}not installed${clear}."
        echo -e "The program will now ask for permission to run: "
        echo -e "${brigreen}sudo apt update && sudo apt install sox${clear}"
        sudo apt update && sudo apt install sox
    fi
    playSound &
    playSoundProcessId=$!
    while read -r URL; do
        status=$(curl -Is "$URL" | head -n 1 | awk '{print $2}')
        if [[ $status =~ ^2|3 ]]; then
            echo -e "${blue}$URL${clear} --> ${thumbsUp} Accessible ($status)"
        else
            echo -e "$URL -->${thumbsDown} Unreachable"
        fi
    done < "$theFile"
    kill "$playSoundProcessId" 2>/dev/null
    wait "$playSoundProcessId" 2>/dev/null
}

while true; do
    showMenu
    echo -n "Enter number: "
    read val
    if [ "$val" == "1" ]; then
        addWebsite
    elif [ "$val" == "2" ]; then
        listWebsite
    elif [ "$val" == "3" ]; then
        removeWebsite
    elif [ "$val" == "4" ]; then
        editWebsite
    elif [ "$val" == "5" ]; then
        checkWebsite
    elif [ "$val" == "6" ]; then
        echo -n -e "Are you sure? ${skull} [Y/n]: "
        read w
        if [[ -z "$w" || "${w}" == "y" || "${w}" == "Y" ]]; then
            echo -e "${magenta}Exiting. Bye Bye${clear}"
            break
        elif [[ "$w" == "n" || "$w" == "N" ]]; then
            echo -e "${briyellow}No? Good.${clear}"
        else
            echo -e "You pressed something else entirely. ${brired}Not ready it seems${clear}. Go back Home."
        fi
    else
        echo -e "${brired}Invalid Input${clear}! Try again."
    fi
    echo " "
done
