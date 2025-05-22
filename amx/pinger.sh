#!/bin/bash

# Tool used to moniter status of websites

if ! [ -f ./tracklist.txt ]
then
    echo "Tracklist doesnt exists"
    echo "Creating tracklist.txt"
    touch ./tracklist.txt
fi

add_site() {
    if [ -z $(grep $1 ./tracklist.txt) ]
    then
        echo "adding $1"
        echo "$1" >> ./tracklist.txt
        echo "$1 added successfully"
    else
        echo "Site already present in the track list"
        echo "use -l to view all sites!"
    fi

    exit 1
}

del_site() {
    if [ -z $(grep $1 ./tracklist.txt) ]
    then
        echo "Site not present in the track list"
        echo "use -a to add site!"
    else
        echo "deleting $1"
        sed -i "/^$1/d" ./tracklist.txt
        echo "deleted succeessfully $1"
    fi

    exit 2
}


help(){
    echo "pinger [OPTIONS]... [FLAGS]..."
    echo "FLAGS"
    echo "-p : run pinger on tracklist"
    echo "OPTIONS"
    echo "-a : add site to tracklist"
    echo "-d : delete site from tracklist"
    echo "-l : list all sites in tracklist"
    echo "-h : show this menu"
    exit 3
}

while getopts ":pa:d:l" opt
do
    case $opt in
        p) echo "pinging sites";;
        a) input=$OPTARG;add_site "$input";;
        d) input=$OPTARG;del_site "$input";;
        l) echo "list site";;
        \?) help ;exit 1
    esac
done