#!/bin/sh

RED='\033[1;31m'
BLUE='\033[1;36m'
GREEN='\033[1;32m'
ORANGE='\033[1;33m'
UNDERLINE='\033[3;4m'
RESET='\033[0m'

printf $BLUE
printf ' .......................................................................... \n'; sleep 0.1
printf ' . __________ ___           _   _______                   _               . \n'; sleep 0.1
printf ' . \_   ____/ \ |  _____  _| |_(   __  )  _____   _____  (_) _  _    _    . \n'; sleep 0.1
printf ' .  |  ____)  | |  \__  ||_   _|)   _ (  /  __ ) /  _  \ | |\ \/ / _|_|_  . \n'; sleep 0.1
printf ' .  |   \     | |  / __  \ | | /  | \  \(   ___)( |\ /| )| | )  (_[_|_|_] . \n'; sleep 0.1
printf ' .  \____)   [___](______/ |_| \__|  \__\\____ > \| V |/ |_\/_/\_\  |_|   . \n'; sleep 0.1
printf ' .                                                                        . \n'; sleep 0.1
printf ' .......................................................................... \n'; sleep 0.1
printf $RESET

if [ $# -lt 3 ]
then
  printf "    ${GREEN}Usage:${RESET} ${UNDERLINE}$0${RESET} ${ORANGE}<VARIANT_NAME> <HIGHLIGHT_HEX_COLOR> <HIGHLIGHT_TEXT_HEX_COLOR>${RESET}\n"
  printf "                                                                                                                                  \n"
  printf "        ${GREEN}Example:${RESET} ${UNDERLINE}$0${RESET} ${ORANGE}FOOBAR '#123456' '#987654'${RESET}                           \n"
  EXIT=1
fi

check_dependencies() {
    local missing=0
    local -a deps=(make inkscape sassc)

    for dep in "${deps[@]}"; do
        if ! command -v "$dep" > /dev/null; then
            printf "   ${RED} !! YOU NEED TO INSTALL ${RESET}$dep\n"
            missing=1
        fi
    done

    if ! command -v optipng > /dev/null; then
        printf "   ${ORANGE} !! OPTIONALLY INSTALL optipng for assets minification${RESET}\n"
    fi

    if [ $missing -eq 1 ]; then
        EXIT=1
    fi
}

check_dependencies

[ -z $EXIT ] || exit 1


sleep 1

eval export COLOR_VARIANTS=$1
eval export COLOR_$COLOR_VARIANTS=$2
eval export TEXT_COLOR_$COLOR_VARIANTS=$3

rm -rf themes/*
make -j build
