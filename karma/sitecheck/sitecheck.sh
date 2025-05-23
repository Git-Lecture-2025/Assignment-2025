#!/bin/bash

cd ~
if ! test -d "./.config"
then
    mkdir ./.config/;
fi

cd ~/.config/
if ! test -d "./sitecheck/"
then
    mkdir ./sitecheck/;
    touch ./sitecheck/track_list.txt
fi

list=~/.config/sitecheck/track_list.txt

script_args=$@

########function zone########################
function error_dictionary {
    case $1 in
        "0") echo "all good";;
        "6") echo "unresolved hostname";;
        *) echo "curl exit code $1"
    esac
}
function code_dictionary {
    case $1 in 
        "200") echo "OK";;
        "301") echo "Moved Permanently";;
        "302") echo "Moved Temporarily";;
        "400") echo "Bad request";;
        "401") echo "Unauthorized";;
        "403") echo "Forbidden";;
        "404") echo "Not Found";;
        "405") echo "Method not Allowed";;
        "408") echo "Request Timeout";;
        "503") echo "Service Unavailable";;
        "000") echo $(error_dictionary $2);;
        *) echo "Error"
    esac
}

response_code=0
curl_exit_code=0

function just_display {
    decor_heading
    echo "---developed by karma---"
    echo 
    echo
    for item in $(cat $list)
    do
        response_code=$(curl -s -m 10 -w "%{http_code}" -I "$item" -o /dev/null)    
        curl_exit_code=$?
        echo "Site : $item" 
        desc=$(code_dictionary $response_code $curl_exit_code)
        echo "Status - $response_code ( $desc )"
        echo "----------------------------"
    done
    echo
    echo "use -h to know more"
    echo
    sleep 0.5s
    echo "SiteCheck completed on :-"
    echo "$(date)"
}

function extract_switch_commands {
    r=""
    for arg in $script_args
    do
        if [ ${arg:0:1} == "-" ]
        then 
            r=$r${arg:1}
            # echo "$r"
        else
            echo "invalid command $arg"
        fi
    done
    echo "$r"
}

function add_url() {
    bul=true
    for url in $(cat $list)
    do
        if [ $url == $1 ]
            then bul=false ; break;
        fi
    done

    if [ $bul != true ]
    then
    echo "NOT ADDING $1"
    echo "this site is already being tracked."
    else
    echo "$1" >> $list
    echo "ADDED $1 to the tracking list"
    fi
}

function display_url() {
    decor_heading
    echo "---developped by karma---"
    echo 
    echo "Tracked Sites"
    echo "---------------------------------------"
    cat $list
    echo "---------------------------------------"
    echo 
}

function edit_list() {
    x=$'\n' read -d '' -r -a lines < $list
    i=1
    for l in ${lines[@]}
    do
    echo "$i) $l"
    i=$(expr $i + 1)
    done

    isok=true;
    while $isok
    do
    echo
    echo "Which line to edit? (enter S.No)"
    read r
        if [ $(expr $r ) -gt ${#lines[@]} ] || [ $r -le 0 ]
        then
        echo -e "\nplease enter valid index"; continue
        fi
        isok=false
    done

    r=$(expr $r - 1)
    echo "> [${lines[$r]}] edit to :-" 
    read resp
    lines[$r]=$resp

    echo "" > $list
    for l in ${lines[@]}
    do
    echo "$l" >> $list
    done
}

function remove_url() {
    r=""
    for url in $(cat $list)
    do
        if [ $url != $1 ]
        then
            r=$r"\n"$url
        fi
    done
    echo -e "$r" > $list 
    echo "removing $1 from the list."
}

function help_menu() {
    decor_heading
    echo "your useful site tracking tool..."
    echo "---developed by karma---"
    echo 
    echo "PURPOSE -> Tracks all the urls listed in the list.txt file,"
    echo "the list can be manipulated using the following sub-commands."
    echo 
    echo "  -s                       Check status of all Tracked sites (Default function)"
    echo "  -a [arg1] [arg2] ...     Add url(s) to your tracking list."
    echo "  -d                       Display all the urls in your tracking list"
    echo "  -x [arg1] [arg2] ...     Remove url(s) from the tracking list."
    echo "  -e                       To open the tracking list in text editor (for wider range of action)"
    echo "  -h                       To open this help menu" 
    echo 
}

function check_dependency() {
    which figlet >/dev/null
    check1=$?
    which lolcat >/dev/null
    check2=$?

    if [ $check1 -eq 1 ] || [ $check2 -eq 1 ];
        then echo "Please install \`lolcat\` and \`figlet\` (for better user experience)";
        read -p "wanna install? [y/n] " resp ;
        if [ $resp == "y" ];
        then brew install lolcat 2>/dev/null;
        brew install figlet 2>/dev/null;
        apt install lolcat 2>/dev/null;
        apt install figlet 2>/dev/null;
        check1=0; check2=0
        elif [ $resp == "n" ];
        then echo "not installing";
        echo ;
        check1=1;check2=1;
        fi
    fi
}

function decor_heading() {
    echo -e "\033[32m ____  _ _        ____ _               _    \033[0m"
    echo -e "\033[33m/ ___|(_) |_ ___ / ___| |__   ___  ___| | __\033[0m"
    echo -e "\033[36m\___ \| | __/ _ \ |   | '_ \ / _ \/ __| |/ /\033[0m"
    echo -e "\033[36m ___) | | ||  __/ |___| | | |  __/ (__|   < \033[0m"
    echo -e "\033[33m|____/|_|\__\___|\____|_| |_|\___|\___|_|\_\ \033[0m"
    echo 
}

function int_display(){
    resp=$(dialog --menu "choose function" 0 0 0 1 "ping all" 2 "add site" 3 "edit site" 4 "remove site" 5 "display tracked sites" 3>&1 1>&2 2>&3 3>&-)

    case $resp in 
    1)
        dialog --msgbox "
        $(
        for item in $(cat $list)
        do
            response_code=$(curl -s -m 10 -w "%{http_code}" -I "$item" -o /dev/null)    
            curl_exit_code=$?
            echo "Site : $item" 
            desc=$(code_dictionary $response_code $curl_exit_code)
            echo "Status - $response_code ( $desc )"
            echo "----------------------------"
        done
        )" 0 0
        int_display
    ;;
    2)
        site_add=$(dialog --inputbox "enter the site to be added" 0 0 3>&1 1>&2 2>&3 3>&-)

        if [ $? -eq 1 ]
        then dialog --msgbox "nothing added" 0 0;
        else
        add_url "$site_add";
        dialog --title "Site added - " --msgbox "$site_add" 0 0;
        fi

        int_display
    ;;
    3)
        r2=""
        i=1
        for line in $(cat $list)
        do
            r2=$r2"$i $line "; i=$(expr $i + 1)
        done

        x2=$'\n' read -d '' -r -a linearray < $list

        x=$(dialog --menu "choose site to be removed" 0 0 0 $r2 3>&1 1>&2 2>&3 3>&-)

        l_edit=${linearray[$(expr $x - 1)]}

        n=$(dialog --inputbox "edit $l_edit to - " 0 0 3>&1 1>&2 2>&3 3>&-)    

        dialog --title "Edit URL" --msgbox "$l_edit -> $n" 0 0  

        linearray[$(expr $x - 1)]=$n

        echo "" > $list
        for l in ${linearray[@]}
        do
        echo "$l" >> $list
        done

        int_display
    ;;
    4)
        r2=""
        i=1
        for line in $(cat $list)
        do
            r2=$r2"$i $line "; i=$(expr $i + 1)
        done

        x2=$'\n' read -d '' -r -a linearray < $list

        x=$(dialog --menu "choose site to be removed" 0 0 0 $r2 3>&1 1>&2 2>&3 3>&-)

        l_remove=${linearray[$(expr $x - 1)]}
        dialog --title "Removing Site - " --msgbox "$l_remove" 0 0 
        remove_url "$l_remove"
        int_display
    ;;
    5)
        dialog --msgbox "$(cat $list)" 0 0
        int_display
    ;;
    *)dialog --msgbox "exit the interactive mode ?" 0 0; 
    help_menu
    esac
}

####################################################

check1=0
check2=0

if [ $# -eq 0 ]
then just_display $isok
else
    i=1
    curr_command=""
    while [ $i -le $# ]
    do
        if [ ${!i:0:1} == "-" ]
        then curr_command=${!i:1:1} ;i=$(expr $i + 1); 
            if [ $curr_command == "d" ] 
            then display_url $isok;
            elif [ $curr_command == "e" ]
            then edit_list;
            elif [ $curr_command == "h" ]
            then help_menu $isok;
            elif [ $curr_command == "s" ]
            then just_display $isok;
            elif [ $curr_command == "i" ]
            then int_display;
            fi
        continue;
        else 
            case $curr_command in
                "a") add_url ${!i} ;;
                "x") remove_url ${!i} ;;
                *) echo "invalid command(s) found, use -h to know more."
            esac
        fi
        i=$(expr $i + 1)
    done
fi