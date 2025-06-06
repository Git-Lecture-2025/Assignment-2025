#!/bin/bash

RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
END="\e[0m"

websites=()

if [ -f websites.txt ]; then
    mapfile -t websites < websites.txt
fi

saveSite() {
    printf "%s\n" "${websites[@]}" > websites.txt
}

addSite()
{
    clear
    local c="y"
    while [ "$c" = "y" ]
    do
        read -p "Enter website URL to be tracked : " site_url
        curl -I -s "$site_url" > /dev/null
        if ! [  -z "$(curl -L 2>/dev/null $site_url)" ]; then
            websites+=("$site_url")
            saveSite
            echo -e "${GREEN}Added website successfully!${END}"
        else
            echo -e "${RED}Invalid site detected. Please try again.${END}"
        fi
        read -p "Do you want to add another site? (y/n) : " c
    done
}

removeSite()
{
    clear
    local d="y"

    while [ "$d" = "y" ]
    do
        echo ""
        echo "Tracked websites :"
        for i in "${!websites[@]}"; do
            echo -e "${YELLOW} $((i+1)) ${websites[$i]} ${END}"
        done

        read -p "Enter website index to stop tracking : " id
        id=$((id - 1))

        if [ "$id" -ge 0 ] && [ "$id" -lt "${#websites[@]}" ]; then
            site_url="${websites[$id]}"
            f=false
            r_sites=()
            for site in "${websites[@]}"; do
                if [ "$site" = "$site_url" ]; then
                    f=true
                else
                    r_sites+=("$site")
                fi
            done
        else
            echo -e "${RED}Invalid index${END}"
            continue
        fi

        if [ "$f" = true ]; then
            websites=("${r_sites[@]}")
            saveSite
            read -p "Done! Do you want to remove another site? (y/n): " d
        else
            echo -e "${RED}looks like you made a mistake${END}"
            read -p "Do you want to remove another site? (y/n): " d
        fi
        
    done
    echo ""
}

editSite() {
    clear

    if [ ${#websites[@]} -eq 0 ]; then
        echo -e "${YELLOW}No websites are being tracked currently${END}"
        echo ""
        return
    fi

    echo "Tracked websites :"
    for i in "${!websites[@]}"; do
        echo -e "${YELLOW}$((i+1)) ${websites[$i]}${END}"
    done

    read -p "Enter the index to edit : " id
    id=$((id - 1))

    if [ "$id" -ge 0 ] && [ "$id" -lt "${#websites[@]}" ]; then
        read -p "Enter the new URL: " new_url
        if ! [  -z "$(curl -L 2>/dev/null $new_url)" ]; then
            websites[$id]="$new_url"
            saveSite
            echo -e "${GREEN}Website URL updated!${END}"
        else
            echo -e "${RED}Invalid site detected. Please try again.${END}"
        fi
    else
        echo -e "${RED}Invalid index${END}"
    fi
    echo ""
}

checkSite()
{
    clear
    for site in "${websites[@]}"
    do
    code=$(curl -s -L -o /dev/null -w "%{http_code}" "$site")
    if [ "$code" -eq 200 ]; then
        echo "$site is accessible with status code : $code"
    else
        echo "$site cannot be accessed"
    fi
    echo ""
    done
    echo ""
}

while true; do
    echo "Choose an option:"
    echo "1) Add Site"
    echo "2) Remove Site"
    echo "3) Check Sites"
    echo "4) Edit Sites"
    echo "q) Quit"
    read -p "Enter choice : (1/2/3/4/q) " input

    case "$input" in
        1) addSite ;;
        2) removeSite ;;
        3) checkSite ;;
        4) editSite ;;
        q) echo "..."; break ;;
        *) echo "choose one of (1/2/3/4/q)" ;;
    esac
done


