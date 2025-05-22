#!/bin/bash


if [ "$USER" != "root" ]; then
    echo "Please run as root"
    exit
fi


echo "Installing UpTTY ..."
wget -nv --no-cache -O /usr/bin/uptty https://raw.githubusercontent.com/TanmayArya-1p/Assignment-2025/refs/heads/tcan/uptty/uptty

echo "Installing UpTTY TUI ..."
wget -nv --no-cache -O /usr/bin/uptty-tui https://raw.githubusercontent.com/TanmayArya-1p/Assignment-2025/refs/heads/tcan/uptty/uptty-tui

chmod +x /usr/bin/uptty
chmod +x /usr/bin/uptty-tui
uptty version