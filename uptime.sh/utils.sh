remove_site() {
    local target=$1
    local uuidRegex="^$target"
    local nameRegex="^.*,$target,"

    if grep --quiet -e "$uuidRegex" -e "$nameRegex" uptime.csv; then
        sed -i "/$uuidRegex/d;/$nameRegex/d" uptime.csv
        echo "$target removed successfully."
    else
        echo "Target site $target: not found."
    fi
}

add_site(){
    local trackerid=$(uuidgen)
    trackerid=${trackerid:0:8}
    local name=$1
    local url=$2
    local status="unknown"
    local response_time="infinity"
    local last_checked="never"
    echo $trackerid,$name,$url,$status,$response_time,$last_checked >> uptime.csv
}

list_sites() {
    cat uptime.csv| column -t -s "," -N "TRACKER ID,NAME,URL,STATUS,LATENCY,LAST CHECKED" -o " | "
}

# TODO: IMPLEMENT uptimerc FOR -NOTFIICATION,CRONJOB,TIME INTERVAL

clear_line() {
    echo -ne "\r\033[K"
}


edit_tracker() {
    local trackerid=$1
    shift

    local uuidRegex="^$target"
    local nameRegex="^.*,$target,"


    OPTSTRING=":n:u:"
    local line
    line=$(grep -e "$uuidRegex" -e "$nameRegex"  uptime.csv)
    IFS=',' read -r trackerid name url status latency lc <<< "$line"
    if [ -z "$trackerid" ]; then
        echo "Tracker ID $trackerid not found."
        return 1
    fi
    
    while getopts "$OPTSTRING" opt; do
        case $opt in
            n) 
                echo "Editing name from $name to $OPTARG"
                name=$OPTARG ;;
            u) 
                echo "Editing url from $url to $OPTARG"
                url=$OPTARG ;;
            *) 
                echo "Invalid option: -$OPTARG" ;;
        esac
    done
    sed -i "/^$trackerid,/c $trackerid,$name,$url,$status,$latency,$lc" uptime.csv
}

spinner(){
    local spin='|/-\'
    local it=0;
    while :; do
        echo -ne "\r[${spin:$it:1}]"
        it=$((it+1))
        it=$((it%4))
        sleep 0.1
    done
}


check() {
    IFS=","
    while read -r trackerid name url status latency lc; do

        echo -n "[-] Pinging $name ($url)"
        spinner &
        local spinPid=$!


        local res=$(curl -w "%{time_total}" -Is $url)
        local resStat=$(echo $res | head -n 1)
        local resLat=$(echo $res | tail -n 1)
        resLat=${resLat:0:-1}
        resLat="$resLat ms"
        if [[ "$resStat" == *"200"* ]]; then
            status="up"
            latency=$resLat
            kill $spinPid > /dev/null
            clear_line
            echo "[🟢] $name is up, latency: $latency"

        else
            if [ "$status" != "down" ]; then
                notify-send "Tracker '$name' is down"
            fi
            status="down"
            latency="infinity"
            kill $spinPid > /dev/null
            clear_line
            echo "[❌] $name is down, latency: $latency"
        fi
        lc=$(date "+%d-%m-%Y %H:%M:%S")

        local replacement="$trackerid,$name,$url,$status,$latency,$lc"
        sed -i "/^$trackerid,/c $replacement" uptime.csv          
    done < uptime.csv    
}


desc() {
    local target=$1
    local uuidRegex="^$target,"
    local nameRegex="^.*,$target,"

    local line
    line=$(grep -e "$uuidRegex" -e "$nameRegex"  uptime.csv)
    IFS=',' read -r trackerid name url status latency lc <<< "$line"
    if [ -z "$trackerid" ]; then
        echo "Tracker ID $trackerid not found."
        return 1
    fi

    echo "----------------------------------------"
    echo "Tracker ID: $trackerid"
    echo "Name: $name"
    echo "URL: $url"
    echo "Status: $status"
    echo "Latency: $latency"
    echo "Last Checked: $lc"
    echo "----------------------------------------"
    echo ""
}


