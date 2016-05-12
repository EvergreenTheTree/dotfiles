#!/bin/bash
# Autostart programs under ~/.config/i3/autostart using dex if they haven't
# already been started.
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [ ! -f "$DIR/did_autostart" ] && [ -x "$DIR/dex/dex" ]; then
	if command -v python3 >/dev/null 2>&1; then
		touch "$DIR/did_autostart"
		python3 "$DIR/dex/dex" -a -s "$DIR/autostart"
	fi
fi
