#!/usr/bin/env bash

function _rofi() {
    rofi -kb-accept-entry "!Return" "$@"
}

if [[ ! -f "$HOME/.cache/dice_hist" ]] || [[ $(wc -l <"$HOME/.cache/dice_hist") -eq 0 ]]; then
    printf "\n" > "$HOME/.cache/dice_hist"
fi

dice="$(echo "New roll" | cat - "$HOME/.cache/dice_hist" | _rofi -dmenu -p "Roll dice")"

if [[ $dice == "New roll" ]]; then
    dice="$(_rofi -dmenu -p "Roll dice" )"
fi

if ! roll "$dice" >/dev/null 2>&1; then
    _rofi -e "No dice rolled."
    exit 1
fi

grep -q "^$dice\$" "$HOME/.cache/dice_hist" || sed -i "1s/^/$dice \n/" "$HOME/.cache/dice_hist"
result="$(roll -v "$dice" | tee "$HOME/.cache/dice_res")"
_rofi -e "$result"
