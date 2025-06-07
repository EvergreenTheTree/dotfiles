#!/usr/bin/env bash

echo -en "\0prompt\x1f \n"

function main_menu() {
    echo -en "\0no-custom\x1ftrue\n"
    echo "New roll"
    cat "$HOME/.cache/dice_hist"
}
if [[ $ROFI_RETV -eq 0 ]]; then
    echo -en "\0message\x1fRoll new dice or select a previous roll\n"
    main_menu
    exit 0
fi

if [[ $ROFI_RETV -eq 1 && $1 == "New roll" ]]; then
    echo -en "\0no-custom\x1ffalse\n"
    echo -en "\0message\x1fEnter new roll expression\n"
    echo -en " \n"
    exit 0
fi

[[ $ROFI_DATA == "rolled" ]] && exit 0

dice="$1"

if ! roll "$dice" >/dev/null 2>&1; then
    echo -en "\0message\x1fInvalid dice roll. Roll new dice or select a previous roll\n"
    main_menu
    exit 0
fi

if [[ ! -f "$HOME/.cache/dice_hist" ]] || [[ $(wc -l <"$HOME/.cache/dice_hist") -eq 0 ]]; then
    echo "" > "$HOME/.cache/dice_hist"
fi

grep -q "^$dice\$" "$HOME/.cache/dice_hist" || sed -i "1s/^/$dice \n/" "$HOME/.cache/dice_hist"
echo -en "\0data\x1frolled\n"
echo -en "\0keep-selection\x1ffalse\n"
echo -en "\0message\x1fResults\n"
roll -v "$dice" | tee "$HOME/.cache/dice_res"
