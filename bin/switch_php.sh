#!/bin/bash
# ----------------------------------------------------------------------------
# Switch between php versions including icu4c reinstall
# @modified 05-Aug-2020
# ----------------------------------------------------------------------------

php_version="7.4"
brew_prefix=$(brew --prefix)
php_opt_dir="${brew_prefix}/opt"

brew_array=("5.6","7.0","7.1","7.2","7.3","7.4")
php_array=("php@5.6" "php@7.0" "php@7.1" "php@7.2" "php@7.3" "php@7.4")

function usage()
{
cat <<EOF
Usage:  $0 [OPTIONS]

This script switches php versions
- Stops running service
- Relink php versions

OPTIONS:
  -v  php version (default $PHP_VERSION)
  -h  Show this message

EOF
}

function error()
{
  echo -e "Error: $1"
  [[ ! "$2" == "noexit" ]] && exit 1
}

PRINT=""
while getopts "v:h" OPTION; do
  case $OPTION in
    v)
      php_version=$OPTARG
      ;;
    h)
      usage
      exit 0
      ;;
    :)
      error "Error: -$OPTION requires an argument" noexit
      usage
      exit 1      ;;
    \?)
      error "Error: unknown option -$OPTION" noexit
      usage
      exit 1
      ;;
    *)
      [[ "$OPTARG" == "" ]] && OPTARG='"-'$OPTION' 1"'
      OPTION="OPT_$OPTION"
      eval ${OPTION}=$OPTARG
      ;;
  esac
done

php_version="php@$php_version"
printf "Processing $php_version\n"

last_dir=$(pwd)
cd $php_opt_dir

# What versions of php are installed via brew
printf " - check installed php versions: "
for i in ${php_array[*]}; do
    if [[ -n "$(brew ls --versions "$i")" ]]; then
        php_installed_array+=("$i")
    fi
done
echo ${php_installed_array[*]}

# Stop php service
printf " - stopping php services: "
php_running=`brew services | grep php | grep started | cut -f1 -d' '`
if [[ -n $php_running ]]; then
    echo "$php_running"
    brew services stop $php_running
else
    echo "none"
fi

# Check that the requested version is supported
printf " - checking version supported: "
if [[ " ${php_array[*]} " == *"$php_version"* ]]; then
    # Check that the requested version is installed
    if [[ " ${php_installed_array[*]} " == *"$php_version"* ]]; then
        printf "OK\n"
        echo " - relink to brew $php_version"
        for i in ${php_installed_array[@]}; do
            brew unlink $i
        done
        brew link --force $php_version

        echo " - pwd: "
        pwd
        ls -al php
        echo " - extracting symlink via cmd: ls -l $php_version | tr -s ' ' | cut -f11 -d' '"
        symlink=`ls -l $php_version | tr -s ' ' | cut -f11 -d' '`
        echo " - relink php symlink to $symlink"
        rm php
        ln -s $symlink php

        echo " - restart php service"
        brew services start $php_version
    else
        echo "Sorry, but $php_version is not installed via brew. Install by running: brew install $php_version"
    fi
else
    echo "Unknown version of PHP. PHP Switcher can only handle arguments of:" ${brew_array[@]}
fi

ps auwx | grep php
php -v
echo " - finished"

cd $last_dir
exit
