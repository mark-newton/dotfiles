#!/bin/bash
# ----------------------------------------------------------------------------
# Switch between php versions including icu4c reinstall
# @modified 05-Jun-2020
# ----------------------------------------------------------------------------

PHP_FROM="7.1"
PHP_TO="7.4"
ICU4C_OLD="brew reinstall https://raw.githubusercontent.com/Homebrew/homebrew-core/896d1018c7a4906f2c3fa1386aaf283497db60a2/Formula/icu4c.rb"
ICU4C_NEW="brew reinstall icu4c"
PHP_DIR="/usr/local/opt"

function usage()
{
cat <<EOF
Usage:  $0 [OPTIONS]

This script switches php versions
- Stops running service
- Relink php versions
- Reinstall icu4c

OPTIONS:
  -f  From php (defaults to $PHP_FROM)
  -t  To php (defaults to $PHP_TO)
  -h  Show this message

EOF
}

function error()
{
  echo -e "Error: $1"
  [[ ! "$2" == "noexit" ]] && exit 1
}

PRINT=""
while getopts "f:t:vh" OPTION; do
  case $OPTION in
    f)
      PHP_FROM=$OPTARG
      ;;
    t)
      PHP_TO=$OPTARG
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

LAST_DIR=$(pwd)

echo "brew services stop php/php@$PHP_FROM"
brew services stop php
brew services stop php@$PHP_FROM

echo ""
echo "brew unlink php@$PHP_FROM && brew link --force --overwrite php@$PHP_TO"
brew unlink php@$PHP_FROM && brew link --force --overwrite php@$PHP_TO

echo "ln -s php@$PHP_TO php"
cd $PHP_DIR
rm php
ln -s php@$PHP_TO php

echo ""
if [ "$PHP_TO" == '5.6' ]
then
  echo $ICU4C_OLD
  eval $ICU4C_OLD
elif [ "$PHP_TO" == '7.1' ]
then
  echo $ICU4C_OLD
  eval $ICU4C_OLD
elif [ "$PHP_TO" == '7.2' ]
then
  echo $ICU4C_NEW
  eval $ICU4C_NEW
elif [ "$PHP_TO" == '7.4' ]
then
  echo $ICU4C_NEW
  eval $ICU4C_NEW
fi

echo ""
echo "brew services start php@$PHP_TO"
brew services start php@$PHP_TO

ps auwx | grep php
php -v

cd $LAST_DIR
