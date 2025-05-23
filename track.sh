#!/bin/bash

websites=("https://www.google.com")

addSite()
{
    local c="y"
    while [ "$c" = "y" ]
    do
        read -p "Enter website URL to be tracked : " site_url
        websites+=("$site_url")
        read -p "Done! Do you want to add another site? (y/n)" c
    done
}

removeSite()
{
    local d="y"

    while [ "$d" = "y" ]
    do
        echo ""
        echo "Tracked websites :"
        for i in "${!websites[@]}"; do
            echo "$((i+1)) ${websites[$i]}"
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
            echo "Invalid index"
            continue
        fi

        if [ "$f" = true ]; then
            websites=("${r_sites[@]}")
            read -p "Done! Do you want to remove another site? (y/n): " d
        else
            echo "looks like you made a mistake"
            read -p "Do you want to remove another site? (y/n): " d
        fi
        
    done
    echo ""
}

editSite() {
    echo ""
    echo "Tracked websites :"
    for i in "${!websites[@]}"; do
        echo "$((i+1)) ${websites[$i]}"
    done

    read -p "Enter the index to edit : " id
    id=$((id - 1))

    if [ "$id" -ge 0 ] && [ "$id" -lt "${#websites[@]}" ]; then
        read -p "Enter the new URL: " new_url
        websites[$id]="$new_url"
        echo "Website URL updated!"
    else
        echo "Invalid index"
    fi
    echo ""
}

checkSite()
{
    echo ""
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


