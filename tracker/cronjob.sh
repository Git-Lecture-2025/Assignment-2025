#!/bin/bash

source functions.sh

logfile=$1

if [ -e "$logfile" ]; then
    {
        echo -n "LOG ENTRY: "
        date
        status
        echo ""
        echo ""
    } >> "$logfile"
fi