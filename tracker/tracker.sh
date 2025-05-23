#!/bin/bash

commands=( 
	"track" "track url1 [url2] [url3] ...: Add(s) (a) website(s) to the tracking list."
	"untrack" "untrack id1/url2 [id2/url2] ...: Remove(s) (a) website(s) from the tracking list."
	
	"status" "status [id1] [id2] ...: Displays the status of the requested websites."
	"display" "display: Displays all the tracked webistes."

	"help" "help: Displays this message."
	"exit" "exit: Exits the control loop."

	"clear" "clear: Clears the terminal."
)

data=".data.txt"
touch "$data"

source "functions.sh"

function push() {
	local line=$(( $(wc -l < "$data") + 1 ))
    echo "$1" >> "$data"
}

function track() {
	if [[ "$#" -eq 0 ]]; then
		echo "No websites passed..."
		return
	fi

	for url in "$@"; do
		if grep -Fq "$url" "$data"; then
			echo "Already tracking: $url..."
			return
		fi

		local code=$(curl -s -o /dev/null -w "%{http_code}" "$url")
		case "$code" in
			"404"|"000")
				echo "Err: Failed to track website. It may not exist."
				;;
			*)
				push "$url"

				local line=$(( $(wc -l < "$data")))
				echo "Now tracking $url... at ID: $line"
				;;
		esac
	done
}

function contains() {
	local value="$1"
	shift
	for item in "$@"; do
		if [[ "$item" == "$value" ]]; then
			return 0
		fi
	done

	return 1
}

function untrack() {
    if [[ "$#" -eq 0 ]]; then
        echo "No ids passed..."
        return
    fi

	local lines=()
	while IFS= read -r line; do
  		lines+=("$line")
	done < "$data"

	if [[ "${#lines[@]}" -eq 0 ]]; then
		echo "Currently tracking no websites..."
		return
	fi

    > "$data"  

	local i
	local resolved=0
    for ((i = 0; i < ${#lines[@]}; i++)); do
        if contains "${lines[$i]}" "$@" || contains "$((i + 1))" "$@"; then
			echo "-> No longer tracking: ${lines[$i]}"
			((resolved++))
            continue
        fi

        echo "${lines[$i]}" >> "$data"
	done

	echo "Untracked ${resolved} arguments successfully."
	if (( resolved > 0 && resolved != "$#" )); then
		echo "Failed to resolve remaining arguments..."
	fi
}

function getStatus() {
	local code=$(curl -s -o /dev/null -w "%{http_code} %{time_total}" "$1")
	IFS=' ' read -r -a code <<< "$code"

	echo "Tracking Result: ${1}; Response Code: ${code[0]}; Latency: ${code[1]}"
}

function status() {
	echo "-----Tracking Results------" 

	local lines=$(( $(wc -l < "$data") ))
	if [[ "$#" -eq 0 ]]; then
        if [[ $lines -eq 0 ]]; then
            echo "No websites being tracked currently..."
            return
        fi
 
		while IFS= read -r line; do
			getStatus "$line"
		done < "$data"
	else
		for id in "$@"; do
			if [[ "$id" -le 0 || "$id" -gt "$lines" ]]; then
				echo "Invalid ID: ${id}, ignoring..."
				return
			fi

			getStatus $(sed -n "${id}p" .data.txt)
		done
	fi
}

function display() {
	echo "-----Currently Tracking-----"

	local lines=$(( $(wc -l < "$data") ))
	if [[ $lines -eq 0 ]]; then
		echo "No websites being tracker currently..."
		return
	fi

	local i=1
	while IFS= read -r line; do
  		echo "$i. $line"
		((i++))
	done < "$data"
}

function help() {
	echo "-----Simple Website Tracker™-----"
	
	echo ""
	echo "Commands:"

	for ((i = 1; i < ${#commands[@]}; i += 2)); do
		echo "$((i / 2 + 1)). " "${commands[i]}"
	done
}

function loop() {
	while true; do
		local args
		read -p "> " -a args

		local cmd=${args[0]}

		if [[ "$cmd" == "exit" ]]; then
			break
		elif [[ "$cmd" == "clear" ]]; then
			clear
			continue
		fi

		local i
		for ((i = 0; i < ${#commands[@]}; i += 2)); do
			local cur=${commands[i]}
			if [[ "$cmd" == "$cur" ]]; then
				"${commands[i]}" "${args[@]:1}"
				break
			fi
		done

		if [[ $i -ge ${#commands[@]} ]]; then
			echo "Err: Command not found. Use help for more info."
		fi
	done
}

echo ""
echo ""
echo ""

echo "   ______  ______  ______  ______  __  __   ______  ______  ______  __    __    "
echo "  /\__  _\/\  == \/\  __ \/\  ___\/\ \/ /  /\  ___\/\  == \/\__  _\/\ \"-./  \   "
echo "  \/_/\ \/\ \  __<\ \  __ \ \ \___\ \  _\"-.\ \  __\\  \  __<\/_/\ \/\ \ \-./\ \  "
echo "     \ \_\ \ \_\ \_\ \_\ \_\ \_____\ \_\ \_\\  \_____\ \_\ \_\ \ \_\ \ \_\ \ \_\ "
echo "      \/_/  \/_/ /_/\/_/\/_/\/_____/\/_/\/_/ \/_____/\/_/ /_/  \/_/  \/_/  \/_/ "
echo "                                                                                "

echo "                               Made by Kunal with 🤍                            "

echo ""
echo ""
echo ""

help
loop
