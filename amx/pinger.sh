#!/bin/bash


# COLOR DUMP
bold=`echo -en "\e[1m"`
underline=`echo -en "\e[4m"`
dim=`echo -en "\e[2m"`
strickthrough=`echo -en "\e[9m"`
blink=`echo -en "\e[5m"`
reverse=`echo -en "\e[7m"`
hidden=`echo -en "\e[8m"`
normal=`echo -en "\e[0m"`
black=`echo -en "\e[30m"`
red=`echo -en "\e[31m"`
green=`echo -en "\e[32m"`
orange=`echo -en "\e[33m"`
blue=`echo -en "\e[34m"`
purple=`echo -en "\e[35m"`
aqua=`echo -en "\e[36m"`
gray=`echo -en "\e[37m"`
darkgray=`echo -en "\e[90m"`
lightred=`echo -en "\e[91m"`
lightgreen=`echo -en "\e[92m"`
lightyellow=`echo -en "\e[93m"`
lightblue=`echo -en "\e[94m"`
lightpurple=`echo -en "\e[95m"`
lightaqua=`echo -en "\e[96m"`
white=`echo -en "\e[97m"`
default=`echo -en "\e[39m"`
BLACK=`echo -en "\e[40m"`
RED=`echo -en "\e[41m"`
GREEN=`echo -en "\e[42m"`
ORANGE=`echo -en "\e[43m"`
BLUE=`echo -en "\e[44m"`
PURPLE=`echo -en "\e[45m"`
AQUA=`echo -en "\e[46m"`
GRAY=`echo -en "\e[47m"`
DARKGRAY=`echo -en "\e[100m"`
LIGHTRED=`echo -en "\e[101m"`
LIGHTGREEN=`echo -en "\e[102m"`
LIGHTYELLOW=`echo -en "\e[103m"`
LIGHTBLUE=`echo -en "\e[104m"`
LIGHTPURPLE=`echo -en "\e[105m"`
LIGHTAQUA=`echo -en "\e[106m"`
WHITE=`echo -en "\e[107m"`
DEFAULT=`echo -en "\e[49m"`

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
        echo "use ./pinger.sh -a <site-name> to single sites"
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
        echo "use ./pinger.sh -l to view all sites!"
    fi

    exit 1
}

del_site() { 
    total_lines=$(cat $trackfile | wc -w)
    echo "Total sites present $total_lines"
    if [ $total_lines -eq 0 ]
    then
        echo "No sites to ping"
        echo "use ./pinger.sh -a <site-name> to single sites"
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

    echo "run ./pinger.sh -l to list all sites with index"

    exit 2
}

edit_site() {
    total_lines=$(cat $trackfile | wc -w)
    echo "Total sites present $total_lines"
    if [ $total_lines -eq 0 ]
    then
        echo "No sites to ping"
        echo "use ./pinger.sh -a <site-name> to single sites"
        exit 2
    fi

    line=$1
    echo "editting site $line"

    if [ -z $line ]
    then 
        echo "Please input a non-empty index!"
    elif [[ $line -ge 1 && $line -le $total_lines ]]
    then
        echo "Enter new site name:"
        read edit

        sed -i "$line c \
        $edit" $trackfile
        echo "site id $line changed to $edit"
    else    
        echo "Enter a valid index"
    fi

    echo "run ./pinger.sh -l to list all sites with index"

    exit 2
}

list_site(){
    if [ -z "$(cat $trackfile)" ]
    then
        echo "No sites to ping"
        echo "use ./pinger.sh -a <site-name> to single sites"
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
    echo "./pinger.sh  [OPTIONS]... [FLAGS]..."
    echo "FLAGS"
    echo "-p : run pinger on tracklist"
    echo "-l : list all sites with in tracklist"
    echo "OPTIONS"
    echo "-a : add site to tracklist"
    echo "-d : delete site by index from tracklist"
    echo "-e : edit site by index from tracklist. prompts you for the new site name"
    echo "-h : show this menu"
    echo ""
    echo "DESCRIPTION"
    echo "      -a [site url], eg. -a www.google.com "
    echo "      -d [site index], eg. -d 4 "
    echo "      -e [site index], eg. -e 4, after this enter the new site name "
    echo ""
    exit 3
}

banner(){
    echo "${orange} WELCOME to pinger."
    echo "#####  # #    #  ####  ###### #####"
    echo "#    # # ##   # #    # #      #    #"
    echo "#    # # # #  # #      #####  #    #"
    echo "#####  # #  # # #  ### #      #####"
    echo "#      # #   ## #    # #      #   #"
    echo "#      # #    #  ####  ###### #    #"
    echo ""
    echo ""
}



# Starting point for the program
while getopts ":pa:d:e:l" opt
do
    case $opt in
        p) pinger;;
        a) input=$OPTARG;add_site "$input";;
        d) input=$OPTARG;del_site "$input";;
        e) input=$OPTARG;edit_site "$input";;
        l) list_site;;
        :) echo "Follow the syntax guidelines!";echo "";help ;exit 1;;
        \?) help ;exit 1
    esac
done

if [ "$OPTIND" -eq 1 ]; then
  banner;
  echo "use ./pinger.sh -h to see all the options"
fi