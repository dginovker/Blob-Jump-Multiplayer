#!/bin/sh
printf '\033c\033]0;%s\a' PillarJumper
base_path="$(dirname "$(realpath "$0")")"
"$base_path/mygame_debug.x86_64" "$@"
