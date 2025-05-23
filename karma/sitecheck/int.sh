#!/bin/bash

dialog --menu "choose fruit" 0 0 0 1 "apple" 2 "banana" 3 "cheeku" 

echo "$?"
if [ $? ]
then
echo "ending the program"
fi