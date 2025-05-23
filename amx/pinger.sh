#!/bin/bash

# Tool used to moniter status of websites
trackfile=./.tracklist.txt
if ! [ -f $trackfile ]
then
    touch $trackfile
fi

#pings each site
ping(){
    echo "Pinging $1"
    status_code=$(curl -s -L -o /dev/null -w "%{response_code}" $1)

    if [ $status_code -eq 200 ]
    then
        echo "Site is up with status code: $status_code"
    else
        echo "Site is down with status code: $status_code"
    fi   
}

pinger() {
    if [ -z "$(cat $trackfile)" ]
    then
        echo "Please add sites to ping"
        echo "use -a <site-name> to single sites"
        exit 4
    fi

    # goes over all sites one by one
    cat $trackfile | while read line 
    do
        ping $line 
    done

    exit 0
}

add_site() {
    if [ -z $(grep $1 $trackfile) ]
    then
        echo "adding $1"
        echo "$1" >> $trackfile
        echo "$1 added successfully"
    else
        echo "Site already present in the track list"
        echo "use -l to view all sites!"
    fi

    exit 1
}

del_site() {
    if [ -z $(grep $1 $trackfile) ]
    then
        echo "Site not present in the track list"
        echo "use -a to add site!"
    else
        echo "deleting $1"
        sed -i "/^$1/d" $trackfile
        echo "deleted succeessfully $1"
    fi

    exit 2
}

list_site(){
    if [ -z "$(cat $trackfile)" ]
    then
        echo "No sites to ping"
        echo "use -a <site-name> to single sites"
        exit 4
    fi
    cat $trackfile
}


help(){
    echo "pinger [OPTIONS]... [FLAGS]..."
    echo "FLAGS"
    echo "-p : run pinger on tracklist"
    echo "-l : list all sites in tracklist"
    echo "OPTIONS"
    echo "-a : add site to tracklist"
    echo "-d : delete site from tracklist"
    echo "-h : show this menu"
    echo ""
    echo "DESCRIPTION"
    echo "      -a [site url], eg. -a www.google.com "
    echo "      -d [site url], eg. -d www.google.com "
    echo ""
    exit 3
}

banner(){
    echo "WELCOME to pinger."
}





# Starting point for the program
while getopts ":pa:d:l" opt
do
    case $opt in
        p) pinger;;
        a) input=$OPTARG;add_site "$input";;
        d) input=$OPTARG;del_site "$input";;
        l) list_site;;
        \?) help ;exit 1
    esac
done

if [ "$OPTIND" -eq 1 ]; then
  banner;
  echo "use -h to see all the options"
fi