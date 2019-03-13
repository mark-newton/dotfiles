
#!/bin/bash
# ----------------------------------------------------------------------------
# Display terminal colors
# @modified 13-Mar-2019
# ----------------------------------------------------------------------------

for fgbg in 38 48 ; do # Foreground / Background
    for color in {0..255} ; do # Colors
        # Display the color
        printf "\e[${fgbg};5;%sm  %3s  \e[0m" $color $color
        # Display 6 colors per lines
        if [ $((($color + 1) % 6)) == 4 ] ; then
            echo # New line
        fi
    done
    echo # New line
done

NC='\033[0m'
printf "\033[0;39mDefault ${NC}\n"
printf "\033[0;30m0 Black ${NC}\n"
printf "\033[0;31m1 Red ${NC}\n"
printf "\033[0;32m2 Green ${NC}\n"
printf "\033[0;33m3 Yellow ${NC}\n"
printf "\033[0;34m4 Blue ${NC}\n"
printf "\033[0;35m5 Magenta ${NC}\n"
printf "\033[0;36m6 Cyan ${NC}\n"
printf "\033[0;37m7 Light gray ${NC}\n"

printf "\n"
printf "\033[0;90m8 Dark gray ${NC}\n"
printf "\033[0;91m9 Light red ${NC}\n"
printf "\033[0;92m10 Light green ${NC}\n"
printf "\033[0;93m11 Light yellow ${NC}\n"
printf "\033[0;94m12 Light blue ${NC}\n"
printf "\033[0;95m13 Light magenta ${NC}\n"
printf "\033[0;96m14 Light cyan ${NC}\n"
printf "\033[0;97m15 White ${NC}\n"

printf "\n"
exit
