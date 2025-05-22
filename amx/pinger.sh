#!/bin/bash

# Tool used to moniter status of websites

while getopts ":pa:d:l" opt
do
    case $opt in
        p) echo "pinging sites";;
        a) input=$OPTARG;echo "$input";;
        d) input=$OPTARG;echo "$input";;
        l) echo "list site";;
        \?) echo "help";exit 1
    esac
done