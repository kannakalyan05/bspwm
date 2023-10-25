#!/bin/bash

if [ "$1" == "--start" ]; then
    /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
elif [ "$1" == "--stop" ]; then
    pkill -f "/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1"
else
    echo "Usage: $0 [--start|--stop]"
    exit 1
fi

