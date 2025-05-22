#!/bin/bash

touch list.txt
list="./list.txt"
script_args=$@

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
        "400") echo "Bad request";;
        "401") echo "Unauthorized";;
        "403") echo "Forbidden";;
        "404") echo "Not Found";;
        "405") echo "Method not Allowed";;
        "408") echo "Request Timeout";;
        "000") echo $(error_dictionary $2);;
        *) echo "Error"
    esac
}

response_code=0
curl_exit_code=0

function just_display {
    check_dependency
    conditional_heading
    echo "---developed by karma---"
    echo 
    echo
    for item in $(cat $list)
    do
        response_code=$(curl -s -w "%{http_code}" -I "$item" -o /dev/null)    
        curl_exit_code=$?
        echo "Site : $item" 
        desc=$(code_dictionary $response_code $curl_exit_code)
        echo "Status - $response_code ( $desc )"
        echo "----------------------------"
    done
    echo
    echo "use -h to know more"
    echo
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
    check_dependency
    conditional_heading
    echo "---developped by karma---"
    echo 
    echo "Tracked Sites"
    echo "---------------------------------------"
    cat $list
    echo "---------------------------------------"
    echo 
}

function edit_list() {
    nano $list
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
    check_dependency
    echo -e "\n"
    conditional_heading
    echo "your useful site tracking tool..."
    echo "---developed by karma---"
    echo 
    echo "PURPOSE -> Tracks all the urls listed in the list.txt file, \nthe list can be manipulated using the following sub-commands."
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

function conditional_heading() {
    if [ $check1 -eq 0 ] && [ $check2 -eq 0 ]
    then figlet "SiteCheck" | lolcat -a -s 100 2>/dev/null
    else echo "SiteCheck"
    fi
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
            then int_display $isok;
            fi
        continue;
        else 
            case $curr_command in
                "a") add_url ${!i} ;;
                # "d") ehco "reached here";display_url ;;
                "x") remove_url ${!i} ;;
                # "e") echo "edit url list"; echo ${!i} ;;
                *) echo "invalid command(s) found, use -h to know more."
            esac
        fi
        i=$(expr $i + 1)
    done
fi