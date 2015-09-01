# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

alias rm="rm -i"
alias mv="mv -i"
alias dux="du -h --max-depth=1"
alias findx="find . -type f | xargs -e grep $@"
alias chmod644='find . -type f -not -perm 0644 -not -name '*.sh' -not -name '*.pl' -print -exec chmod 644 {} \;'
alias chmod755='find . -type d -not -perm -755 -print -exec chmod 755 {} \;'
alias chownwww='find . -not -user www-data -print -exec chown www-data:www-data {} \;'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias df="df -h"
alias vi=vim
alias findi='find . | grep -i'
alias calc='bc -l'
grepr() {
  find . -exec grep -Fli $1 {} \;
}

alias vimenc='vim -c '\''let $enc = &fileencoding | execute "!echo Encoding:  $enc" | q'\'''
alias cons='netstat -ant | grep ":80" | wc -l'
alias sqldump="nice -n 19 /usr/bin/mysqldump --opt --lock-tables=false $0 > $0.sql"
alias tarhttp="nice -n 19 tar czfv $0.tgz httpdocs"
alias tarhttpex="nice -n 19 /bin/tar czfv $0.tgz $0.sql httpdocs --exclude=httpdocs/var/cache/* --exclude=httpdocs/media/* --exclude=httpdocs/var/session/* --exclude=httpdocs/var/log/* --exclude=httpdocs/var/report/* --exclude=httpdocs/var/debug/* --exclude=httpdocs/var/backups/* --exclude=httpdocs/tools/*.gz"
alias nsl="nslookup -timeout=5 -query=ANY -nodef $0"
alias digas="dig +nocmd $0 any +multiline +noall +answer"
alias removejunk="find . \( -name '.DS_Store' -o -name '._.DS_Store' \) -exec rm {} \;"
alias cdwww="cd /var/www/vhosts/"
alias fname="find . -type f -name $1"
alias fdname="find . -type d -name $1"
alias fstr="find . -type f | xargs -e grep -lis $0"
alias md5="echo -n '$0' | md5sum"

alias sudos="sudo -s -E"
