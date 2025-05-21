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


list="./list.txt"

response_code=0
curl_exit_code=0

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
echo "done first check"