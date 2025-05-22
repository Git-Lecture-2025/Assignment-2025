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

# TODO: USE NOTIFY-SEND

clear_line() {
    echo -ne "\r\033[K"
}


check() {
    IFS=","
    while read -r trackerid name url status latency lc; do
        echo -n "[-] Pinging $name ($url)"

        local res=$(curl -w "%{time_total}" -Is $url)
        local resStat=$(echo $res | head -n 1)
        local resLat=$(echo $res | tail -n 1)
        resLat=${resLat:0:-1}
        if [[ "$resStat" == *"200"* ]]; then
            status="up"
            latency=$resLat
            clear_line
            echo "[🟢] $name is up, latency: $latency"

        else
            status="down"
            latency="infinity"
            clear_line
            echo "[❌] $name is down, latency: $latency"
        fi
        lc=$(date "+%d-%m-%Y %H:%M:%S")

        local replacement="$trackerid,$name,$url,$status,$latency,$lc"
        sed -i "/^$trackerid,/c $replacement" uptime.csv          
    done < uptime.csv    
}


