function code_dictionary {
    case $1 in 
        "200") echo "OK";;
        "403") echo "Forbidden";;
        "404") echo "Not Found";;
        *) echo "Error"
    esac
}

list="./list.txt"

response_code=0

echo "\n \n"
for item in $(cat $list)
do
    response_code=$(curl -s -w "%{http_code}" -I $item -o /dev/null)    
    echo "Site : $item" 
    # echo $(curl -I $item -s | grep "HTTP")
    desc=$(code_dictionary $response_code)
    echo "Status - $response_code ( $desc )"
    echo "----------------------------"
done
echo "\n \n"

sleep 0.5s
echo "done first check"