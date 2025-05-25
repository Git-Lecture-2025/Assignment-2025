#!/bin/bash


if [ "$USER" != "root" ]; then
    echo "Please run as root"
    exit
fi

echo ""
echo "▄• ▄▌ ▄▄▄·▄▄▄▄▄▄▄▄▄▄ ▄· ▄▌"
echo "█▪██▌▐█ ▄█•██  •██  ▐█▪██▌"
echo "█▌▐█▌ ██▀· ▐█.▪ ▐█.▪▐█▌▐█▪"
echo "▐█▄█▌▐█▪·• ▐█▌· ▐█▌· ▐█▀·."
echo " ▀▀▀ .▀    ▀▀▀  ▀▀▀   ▀ • "
echo ""

if [ -f /usr/bin/uptty ]; then
    echo "Looks like you already have UpTTY installed."
    echo -n "Delete the current installation and install the latest version of UpTTY? (Y/n) "
    read -rn1 inp </dev/tty
    echo
    if [[ "$inp" == "n" || "$inp" == "N" ]]; then
        echo "Exiting Installer!"
        exit
    else 
        rm -f /usr/bin/uptty
        rm -f /usr/bin/uptty-tui
    fi
fi
    

echo "Installing UpTTY ..."
wget -nv --no-cache -O /usr/bin/uptty https://raw.githubusercontent.com/TanmayArya-1p/Assignment-2025/refs/heads/tcan/uptty/uptty

echo "Installing UpTTY TUI ..."
wget -nv --no-cache -O /usr/bin/uptty-tui https://raw.githubusercontent.com/TanmayArya-1p/Assignment-2025/refs/heads/tcan/uptty/uptty-tui

chmod +x /usr/bin/uptty
chmod +x /usr/bin/uptty-tui
uptty version
if [[ $? == 0 ]]; then
    echo "Successfully Installed UpTTY."
else
    echo "Something went wrong during installation."
fi

