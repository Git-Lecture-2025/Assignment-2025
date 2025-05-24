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

source "decor.sh"
source "functions.sh" $datafile

function push() {
	local line=$(( $(wc -l < "$datafile") + 1 ))
    echo "$1" >> "$datafile"
}

function track() {
	if [[ "$#" -eq 0 ]]; then
		echo "${blue}No websites passed...${normal}"
		return
	fi

	for url in "$@"; do
		if grep -q "^$url" "$datafile"; then
			echo "${red}Already tracking: $url...${normal}"
			return
		fi

		local code=$(curl -s -o /dev/null -w "%{http_code}" "$url")
		case "$code" in
			"404"|"000")
				echo "${RED}Err: Failed to track website. It may not exist.${normal}"
				;;
			*)
				push "$url"

				local line=$(( $(wc -l < "$datafile")))
				echo "${green}Now tracking $url... at ID: $line${normal}"
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
        echo "${blue}No ids passed...${normal}"
        return
    fi

	local lines=()
	while IFS= read -r line; do
  		lines+=("$line")
	done < "$datafile"

	if [[ "${#lines[@]}" -eq 0 ]]; then
		echo "${blue}Currently tracking no websites...${normal}"
		return
	fi

    > "$datafile"  

	local i
	local resolved=0
    for ((i = 0; i < ${#lines[@]}; i++)); do
        if contains "${lines[$i]}" "$@" || contains "$((i + 1))" "$@"; then
			echo "${green}No longer tracking: ${lines[$i]}${normal}"
			((resolved++))
            continue
        fi

        echo "${lines[$i]}" >> "$datafile"
	done

	echo "${green}Untracked ${resolved} arguments successfully.${normal}"
	if (( resolved > 0 && resolved != "$#" )); then
		echo "${RED}Failed to resolve remaining arguments...${normal}"
	fi
}

function display() {
	echo "-----Currently Tracking-----"

	local lines=$(( $(wc -l < "$datafile") ))
	if [[ $lines -eq 0 ]]; then
		echo "${blue}No websites being tracker currently...${normal}"
		return
	fi

	local i=1
	while IFS= read -r line; do
  		echo "${green}$i. $line${normal}"
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
		echo "${red}Failed to resolve timeout${normal}"
		return
	fi

	if crontab -l 2>/dev/null | grep -q "cronjob.sh"; then
		echo "${blue}Cron job already exists...${normal}"
		return
	fi

	if [ -e cronjob.sh ]; then
		if [[ $1 =~ ^[0-9]+$ ]] && [ "$1" -gt 0 ]; then
			local patern="*/$1 * * * * $(realpath "cronjob.sh") $(realpath functions.sh) $(realpath "$datafile") $(realpath "$logfile")"
			(crontab -l 2>/dev/null; echo "$patern") | crontab -

			echo "${green}Cron job successfully set up${normal}"
		else
			echo "${blue}The timout must be a natural number...${normal}"
		fi
	else
		echo "${RED}Err: Failed to reoslve cronjob shell file... The file may have been deleted${normal}"
	fi
}

function cronlog() {
	echo "Cron logs are stored at: $(realpath "$logfile")"
}

function uncron() {
	if ! crontab -l 2>/dev/null | grep -q "cronjob.sh"; then
		echo "${blue}No cron job running to stop...${normal}"
		return
	fi

	crontab -l 2>/dev/null | grep -v "cronjob.sh" | crontab -
	echo "${green}Successfully removed cron job${normal}"
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
			echo "${RED}Err: Command not found. Use help for more info.${normal}"
		fi
	done
}

echo ""
echo ""
echo ""

echo "   ______  ______  ______  ______  __  __   ______  ______  ______  __    __    "
echo "${blue}  /\__  _\/\  == \/\  __ \/\  ___\/\ \/ /  /\  ___\/\  == \/\__  _\/\ \"-./  \   ${normal}"
echo "  \/_/\ \/\ \  __<\ \  __ \ \ \___\ \  _\"-.\ \  __\\  \  __<\/_/\ \/\ \ \-./\ \  "
echo "${blue}     \ \_\ \ \_\ \_\ \_\ \_\ \_____\ \_\ \_\\  \_____\ \_\ \_\ \ \_\ \ \_\ \ \_\ ${normal}"
echo "      \/_/  \/_/ /_/\/_/\/_/\/_____/\/_/\/_/ \/_____/\/_/ /_/  \/_/  \/_/  \/_/ "
echo "                                                                                "

echo "${red}                               Made by Kunal with 🤍                            ${normal}"

echo ""
echo ""
echo ""

help
loop
