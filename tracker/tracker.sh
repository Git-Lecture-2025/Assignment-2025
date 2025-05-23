#!/bin/bash

logfile=".crontrack.log"
touch "$logfile"

datafile=".data.txt"
touch "$datafile"

commands=( 
	"track" "track url1 [url2] [url3] ...: Add(s) (a) website(s) to the tracking list."
	"untrack" "untrack id1/url2 [id2/url2] ...: Remove(s) (a) website(s) from the tracking list."
	
	"status" "status [id1] [id2] ...: Displays the status of the requested websites."
	"display" "display: Displays all the tracked webistes."

	"help" "help: Displays this message."
	"exit" "exit: Exits the control loop."

	"cron" "cron timeout: Sets up a cron job to run \`status\` and log the entries. Note: timeout is in minutes."
	"cronlog" "cronlog: Displays the location of the logfile. Use \`cat\` to display the contents."
	"uncron" "uncron: Stops any existing cron jobs."

	"clear" "clear: Clears the terminal."
)

source "functions.sh" $datafile

function push() {
	local line=$(( $(wc -l < "$datafile") + 1 ))
    echo "$1" >> "$datafile"
}

function track() {
	if [[ "$#" -eq 0 ]]; then
		echo "No websites passed..."
		return
	fi

	for url in "$@"; do
		if grep -q "^$url" "$datafile"; then
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

				local line=$(( $(wc -l < "$datafile")))
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
	done < "$datafile"

	if [[ "${#lines[@]}" -eq 0 ]]; then
		echo "Currently tracking no websites..."
		return
	fi

    > "$datafile"  

	local i
	local resolved=0
    for ((i = 0; i < ${#lines[@]}; i++)); do
        if contains "${lines[$i]}" "$@" || contains "$((i + 1))" "$@"; then
			echo "-> No longer tracking: ${lines[$i]}"
			((resolved++))
            continue
        fi

        echo "${lines[$i]}" >> "$datafile"
	done

	echo "Untracked ${resolved} arguments successfully."
	if (( resolved > 0 && resolved != "$#" )); then
		echo "Failed to resolve remaining arguments..."
	fi
}

function display() {
	echo "-----Currently Tracking-----"

	local lines=$(( $(wc -l < "$datafile") ))
	if [[ $lines -eq 0 ]]; then
		echo "No websites being tracker currently..."
		return
	fi

	local i=1
	while IFS= read -r line; do
  		echo "$i. $line"
		((i++))
	done < "$datafile"
}

function help() {
	echo "-----Simple Website Tracker™-----"
	
	echo ""
	echo "Commands:"

	for ((i = 1; i < ${#commands[@]}; i += 2)); do
		echo "$((i / 2 + 1)). " "${commands[i]}"
	done
}

function cron() {
	if [[ "$#" -ne 1 ]]; then
		echo "Failed to resolve timeout"
		return
	fi

	if crontab -l 2>/dev/null | grep -q "cronjob.sh"; then
		echo "Cron job already exists..."
		return
	fi

	if [ -e cronjob.sh ]; then
		if [[ $1 =~ ^[0-9]+$ ]] && [ "$1" -gt 0 ]; then
			local patern="*/$1 * * * * $(realpath "cronjob.sh") $(realpath functions.sh) $(realpath "$datafile") $(realpath "$logfile")"
			(crontab -l 2>/dev/null; echo "$patern") | crontab -

			echo "Cron job successfully set up"
		else
			echo "The timout must be a natural number..."
		fi
	else
		echo "Err: Failed to reoslve cronjob shell file... The file may have been deleted"
	fi
}

function cronlog() {
	echo "Cron logs are stored at: $(realpath "$logfile")"
}

function uncron() {
	if ! crontab -l 2>/dev/null | grep -q "cronjob.sh"; then
		echo "No cron job running to stop..."
		return
	fi

	crontab -l 2>/dev/null | grep -v "cronjob.sh" | crontab -
	echo "Successfully removed cron job"
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
