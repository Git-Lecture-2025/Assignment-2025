#!/bin/bash

source $1 $2

logfile=$3

if [ -e "$logfile" ]; then
    {
        echo -n "LOG ENTRY: "
        date
        status
        echo ""
        echo ""
    } >> "$logfile"
fi