list="./list.txt"
script_args=$@

function error_dictionary {
    case $1 in
        "0") echo "all good";;
        "6") echo "unresolved hostname";;
        *) echo "some other error"
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
        "408") echo "Request Timeout";;
        "000") echo $(error_dictionary $2);;
        *) echo "Error"
    esac
}

response_code=0
curl_exit_code=0

function just_display {
    echo "\n \n"
    for item in $(cat $list)
    do
        response_code=$(curl -s -w "%{http_code}" -I "$item" -o /dev/null)    
        curl_exit_code=$?
        echo "Site : $item" 
        desc=$(code_dictionary $response_code $curl_exit_code)
        echo "Status - $response_code ( $desc )"
        echo "----------------------------"
    done
    echo "\n \n"
    sleep 0.5s
    echo "SiteCheck completed on :- \n$(date)"
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
    list >> $1
}

function display_url() {
    echo "\n"
    echo "Tracked Sites"
    echo "---------------------------------------"
    cat $list
    echo "\n---------------------------------------"
    echo "\n"
}

####################################################
# just_display

if [ $# -eq 0 ]
then just_display
else
    i=1
    curr_command=""
    while [ $i -le $# ]
    do
        if [ ${!i:0:1} == "-" ]
        then curr_command=${!i:1:1} ;i=$(expr $i + 1); 
            if [ $curr_command == "d" ] 
            then display_url;
            fi
        continue;
        else 
            case $curr_command in
                "a") echo "adding ${!i} to the tracking list." ; add_url ${!i} ;;
                # "d") ehco "reached here";display_url ;;
                "x") echo "remove url(s)"; echo ${!i} ;;
                "e") echo "edit url list"; echo ${!i} ;;
                *) echo "nothing"
            esac
        fi
        i=$(expr $i + 1)
    done
fi