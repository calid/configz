#!/bin/bash

# Author: Dylan Cali <calid1984@gmail.com>
# https://github.com/calid/configz/blob/master/scripts/256colors.sh

# My own take on 256colors printing.. print the color numbers or html color
# codes in a block, wrapping at terminal column width

# Defaults to printing color numbers, pass 'html' to print hex codes

set -e

arg=$1

maxcount=$(tput cols)
declare -i maxcount
declare -i outcount

for c in {0..255};
do
    if [[ $arg == "html" ]]
    then
        code=$(perl -M'Color::ANSI::Util ansi256_to_rgb' \
                    -E "say ansi256_to_rgb($c)")

        printf "\e[1;38;5;${c}m%s\e[0m  " "#$code";
        outcount+=9
    else
        printf "\e[1;38;5;${c}m%03d\e[0m  " $c;
        outcount+=5
    fi

    # 10 chars seems a reasonable margin, and will cover both styles
    if [[ $outcount -ge $(($maxcount-10)) ]]
    then
        printf "\n"
        outcount=0
    fi

done | less -R
