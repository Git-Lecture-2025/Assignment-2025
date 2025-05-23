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
    total_lines=$(cat $trackfile | wc -w)
    echo "Total sites present $total_lines"
    if [ $total_lines -eq 0 ]
    then
        echo "No sites to ping"
        echo "use -a <site-name> to single sites"
        exit 2
    fi

    line=$1

    if [ -z $line ]
    then 
        echo "Please input a non-empty index!"
    elif [[ $line -ge 1 && $line -le $total_lines ]]
    then
        sed -i "$line d" $trackfile
        echo "site id $line removed successfully"
    else    
        echo "Enter a valid index"
    fi

    echo "run with -l to list all sites with index"

    exit 2
}

list_site(){
    if [ -z "$(cat $trackfile)" ]
    then
        echo "No sites to ping"
        echo "use -a <site-name> to single sites"
        exit 4
    fi

    i=1
    cat $trackfile | while read line
    do
        echo "$i: $line"
        i=$(($i+1))
    done 

        
    # cat $trackfile
}


help(){
    echo "pinger [OPTIONS]... [FLAGS]..."
    echo "FLAGS"
    echo "-p : run pinger on tracklist"
    echo "-l : list all sites with in tracklist"
    echo "OPTIONS"
    echo "-a : add site to tracklist"
    echo "-d : delete site by index from tracklist"
    echo "-h : show this menu"
    echo ""
    echo "DESCRIPTION"
    echo "      -a [site url], eg. -a www.google.com "
    echo "      -d [site index], eg. -d 4 "
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
        :) echo "Follow the syntax guidelines!";echo "";help ;exit 1;;
        \?) help ;exit 1
    esac
done

if [ "$OPTIND" -eq 1 ]; then
  banner;
  echo "use -h to see all the options"
fi