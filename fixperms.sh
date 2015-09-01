#!/bin/bash
# ----------------------------------------------------------------------------
# Fix directory and file permissions
# @modified 01-Sep-2015
# ----------------------------------------------------------------------------

PDIR="755"
PFILE="644"
PEXE="755"

DIR_PATH=$(pwd)
OWNER=$(whoami)
[[ "$OWNER" == "root" ]] && OWNER="www-data"

function usage()
{
cat <<EOF
Usage:  $0 [OPTIONS]

This script resets permissions in the nominated directory path:
- Resets ownership to nominated owner where current owner different
- Resets directory permissions to $PDIR if not $PDIR
- Resets file permissions to $PFILE if not $PFILE
- Resets executables to $PEXE (after $PFILE change)

Assumptions:
- Permissions $PDIR for directories and $PFILE for files
- Executables hardcoded in list (mage, *.sh, *.pl)

OPTIONS:
  -p  Path (defaults to current directory)
  -o  Owner (defaults to $OWNER)
  -v  Verbose output
  -h  Show this message

EOF
}

function error()
{
  echo -e "Error: $1"
  [[ ! "$2" == "noexit" ]] && exit 1
}

PRINT=""
while getopts "p:o:vh" OPTION; do
  case $OPTION in
    p)
      DIR_PATH=$OPTARG
      ;;
    o)
      OWNER=$OPTARG
      ;;
    v)
      PRINT="-print"
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

echo "Running fix permissions for $DIR_PATH"
cd $DIR_PATH

echo Resetting ownership to $OWNER
find . ! -user $OWNER $PRINT -exec chown $OWNER:$OWNER {} \;

echo Resetting directories to $PDIR
find . -type d ! -perm $PDIR $PRINT -exec chmod $PDIR {} \;

echo Resetting files to $PFILE
find . -type f ! -name 'mage' ! -name '*.sh' ! -name '*.pl' ! -name 'id_rsa' ! -path '*/var/cache/*' ! -path '*/var/session/*' ! -perm $PFILE $PRINT -exec chmod $PFILE {} \;

echo Resetting executables back to $PEXE
find . -type f \( -name 'mage' -or -name '*.sh' -or -name '*.pl' \) ! -perm $PEXE $PRINT -exec chmod $PEXE {} \;

exit;
