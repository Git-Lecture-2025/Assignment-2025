#!/bin/bash

help(){
    echo "Usage: $0 [options]"
    echo ""
    echo "Commands:"
    echo "  help : Show this help message"
    echo "  add  : Add a new site to monitor"
    echo "  remove, rm : Remove a site from monitoring"
    echo "  ls, list : List all monitored sites"
    echo "  check, ping : Check the status of all monitored sites"
    echo ""
    echo "Options:"
    echo "  -h, --help : Show this help message"
}

remove_site() {
    local target=$1
    local uuidRegex="^$target"
    local nameRegex="^.*,$target,"

    if grep --quiet -e "$uuidRegex" -e "$nameRegex" uptime.csv; then
        sed -i "/$uuidRegex/d;/$nameRegex/d" uptime.csv
        echo "$target removed successfully."
    else
        echo "Target site $target: not found."
    fi
}

add_site(){
    local trackerid=$(uuidgen)
    trackerid=${trackerid:0:8}
    local name=$1
    local url=$2
    local status="unknown"
    local response_time="infinity"
    local last_checked="never"
    echo $trackerid,$name,$url,$status,$response_time,$last_checked >> uptime.csv
}

list_sites() {
    cat uptime.csv| column -t -s "," -N "TRACKER ID,NAME,URL,STATUS,LATENCY,LAST CHECKED" -o " | "
}

# TODO: CLEANUP CODE ,CREATE A UTILS FILE AND PUT ALL THE STUFF THERE
# TODO: THIMK ABOUT INTERACTIVE TUI
# TODO: EDIT ENTRIES
# TODO: desc TO DESCRIBE A TRACKER 
# TODO: COLOURS

case $1 in 
    help|-h|--help)
        help
        ;;
    add)
        add_site "$2" "$3"
        ;;
    remove|rm)
        remove_site "$2"
        ;;
    ls|list)
        list_sites
        ;;
    check|ping) 
        check_sites
        ;;
    *)
        echo "Invalid command: $1"
        help
        ;;
esac
