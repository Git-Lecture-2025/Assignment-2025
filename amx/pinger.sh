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

while getopts ":pa:d:l" opt
do
    case $opt in
        p) echo "pinging sites";;
        a) input=$OPTARG;add_site "$input";;
        d) input=$OPTARG;echo "$input";;
        l) echo "list site";;
        \?) echo "help";exit 1
    esac
done