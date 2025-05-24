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

    echo "${lightyellow}Pinging $1"
    status_code=$(curl -s -L -o /dev/null -w "%{response_code}" $1)

    if [ $status_code -eq 200 ]
    then
        echo "${green}Site is up with status code: $status_code"
    else
        echo "${red}Site is down with status code: $status_code"
    fi   
    echo "${normal}"
}

pinger() {
    if [ -z "$(cat $trackfile)" ]
    then
        echo "${red}"
        echo "No sites to ping"
        echo "${lightyellow}"
        echo "use ./pinger.sh -a <site-name> to single sites"
        echo "${normal}"
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

    target=$1
    output=$(grep $target $trackfile)

    for line in $output
    do 
        if [ $line = $target ]
        then
            echo "${red}"
            echo "Site already present in the track list"
            echo "use ./pinger.sh -l to view all sites!"
            echo "${normal}"
            exit 1
        fi
    done


    echo "${lightyellow}Checking validity of the site: $1"
    if ! [  -z "$(curl -L 2>/dev/null $1)" ]
    then 
        echo "${green}$1 is valid."
    else
        echo "${red}$1 is invalid. Please enter a valid site"
        exit 1
    fi

    echo "${green}adding $1"
    echo "$1" >> $trackfile
    echo "$1 added successfully"
    echo "${normal}"


    exit 1
}

del_site() { 
    total_lines=$(cat $trackfile | wc -w)
    echo "${lightyellow}Total sites present: $total_lines ${normal}"

    if [ $total_lines -eq 0 ]
    then
        echo "${red}"
        echo "No sites to ping"
        echo "${lightyellow}"
        echo "use ./pinger.sh -a <site-name> to single sites"
        echo "${normal}"
        exit 2
    fi

    line=$1

    if [ -z $line ]
    then 
        echo "${red}"
        echo "Please input a non-empty index!"
        echo "${normal}"
    elif [[ $line -ge 1 && $line -le $total_lines ]]
    then
        sed -i "$line d" $trackfile

        echo "${green}site id $line removed successfully"
        echo "${normal}"
    else    
        echo "${red}"
        echo "Enter a valid index"
        echo "${normal}"
    fi

    echo "${lightyellow}run ./pinger.sh -l to list all sites with index"
    echo "${normal}"

    exit 2
}

edit_site() {
    total_lines=$(cat $trackfile | wc -w)
    echo "${lightyellow}Total sites present: $total_lines ${normal}"
    if [ $total_lines -eq 0 ]
    then
        echo "${red}"
        echo "No sites to ping"
        echo "${lightyellow}"
        echo "use ./pinger.sh -a <site-name> to single sites"
        echo "${normal}"
        exit 2
    fi

    line=$1

    if [ -z $line ]
    then 
        echo "${red}"
        echo "Please input a non-empty index!"
        echo "${normal}"
    elif [[ $line -ge 1 && $line -le $total_lines ]]
    then
        echo "${green}Enter new site name:${lightyellow}"
        read edit

        echo "${lightyellow}Checking validity of the site: $edit"
        if ! [  -z "$(curl -L 2>/dev/null $edit)" ]
        then 
            echo "${green}$edit is valid."
        else
            echo "${red}$edit is invalid. Please enter a valid site"
            exit 1
        fi


        sed -i "$line c \
        $edit" $trackfile
        echo "${green}site id $line changed to $edit"
        echo "${normal}"
    else    
        echo "${red}"
        echo "Enter a valid index"
        echo "${normal}"
    fi

    echo "${lightyellow}run ./pinger.sh -l to list all sites with index"
    echo "${normal}"

    exit 2
}

list_site(){
    if [ -z "$(cat $trackfile)" ]
    then
        echo "${red}"
        echo "No sites to ping"
        echo "${lightyellow}"
        echo "use ./pinger.sh -a <site-name> to single sites"
        echo "${normal}"
        exit 4
    fi

    echo "${lightyellow}index: site ${green}"
    i=1
    cat $trackfile | while read line
    do
        echo "$i: $line"
        i=$(($i+1))
    done 
    echo "${normal}"

}


help(){
    echo "${lightyellow}"
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
    echo "${normal}"
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
    echo "${normal}"
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
        :) echo "${red}Follow the syntax guidelines!";echo "${normal}";help ;exit 1;;
        \?) help ;exit 1
    esac
done

if [ "$OPTIND" -eq 1 ]; then
  banner;
  echo "${lightyellow}use ./pinger.sh -h to see all the options ${normal}"
fi