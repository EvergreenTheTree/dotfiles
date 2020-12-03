#!/bin/sh

function player() {
    playerctl --player=spotify,clementine "$@"
}

player_status=$(player status 2> /dev/null)

if [ "$player_status" = "Playing" ]; then
    echo " $(player metadata artist) - $(player metadata title)"
elif [ "$player_status" = "Paused" ]; then
    echo " $(player metadata artist) - $(player metadata title)"
else
    echo " -"
fi
