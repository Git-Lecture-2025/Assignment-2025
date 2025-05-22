#!/bin/bash


source ./utils.sh

help(){
    echo "Usage: $0 [options]"
    echo ""
    echo "Commands:"
    echo "  help : Show this help message"
    echo "  add  : Add a new site to monitor"
    echo "  remove, rm : Remove a site from monitoring"
    echo "  ls, list : List all monitored sites"
    echo "  check, ping : Check the status of all monitored sites"
    echo "  edit, update : Edit the details of a monitored site"
    echo "  desc : Show the description of a monitored site"
    echo ""
    echo "Options:"
    echo "  -h, --help : Show this help message"
}


# TODO: THIMK ABOUT INTERACTIVE TUI
# TODO: README FOR INSTALLATION

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
        check
        ;;
    edit|update)
        edit_tracker "${@:2}"
        ;;
    desc)
        desc "$2"
        ;;
    
    *)
        echo "Invalid command: $1"
        help
        ;;
esac

# TODO: EDGE CASES FOR COMMANDS AND USAGE HELP