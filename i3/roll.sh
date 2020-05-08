#!/usr/bin/env bash

function _rofi() {
    rofi -kb-accept-entry "!Return" "$@"
}

# [[ ! -f "$HOME/dice_hist.txt" ]] && touch "$HOME/dice_hist.txt"

dice="$(_rofi -dmenu -p "Roll dice" <"$HOME/dice_hist.txt")"
if ! roll "$dice" >/dev/null 2>&1; then
    _rofi -e "No dice rolled."
    exit 1
fi

# grep -q "^$dice\$" "$HOME/dice_hist.txt" || sed -i "1s/^/$dice \n/" "$HOME/dice_hist.txt"
result="$(roll -v "$dice" | tee "$HOME/dice.txt")"
_rofi -e "$result"
