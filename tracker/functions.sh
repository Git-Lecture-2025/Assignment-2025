#!/bin/bash

datafile=$1

function getStatus() {
	local code=$(curl -s -L -o /dev/null -w "%{http_code} %{time_total}" "$1")
	IFS=' ' read -r -a code <<< "$code"

	echo "Tracking Result: ${1}; Response Code: ${code[0]}; Latency: ${code[1]}"
}

function status() {
	echo "-----Tracking Results------" 

	local lines=$(( $(wc -l < "$datafile") ))
	if [[ "$#" -eq 0 ]]; then
        if [[ $lines -eq 0 ]]; then
            echo "No websites being tracked currently..."
            return
        fi
 
		while IFS= read -r line; do
			getStatus "$line"
		done < "$datafile"
	else
		for id in "$@"; do
			if [[ "$id" -le 0 || "$id" -gt "$lines" ]]; then
				echo "Invalid ID: ${id}, ignoring..."
				return
			fi

			getStatus $(sed -n "${id}p" $datafile)
		done
	fi
}
