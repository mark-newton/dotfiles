
#!/bin/bash
# ----------------------------------------------------------------------------
# Terminal check
# @modified 05-Jun-2025
# ----------------------------------------------------------------------------

# Check colors
~/bin/colors.sh

# Check terminal features
echo "terminal: $TERM"
printf "\e[3mThis text has italics\e[23m\n"
printf "\e[4:3mThis text has undercurl\e[0m\n"
