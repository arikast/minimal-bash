function u()
{
    dir=""
    if [ -z "$1" ]; then
        dir=..
    elif [[ $1 =~ ^[0-9]+$ ]]; then
        x=0
        while [ $x -lt ${1:-1} ]; do
            dir=${dir}../
            x=$(($x+1))
        done
    else
        dir=${PWD%/$1/*}/$1
    fi
    cd "$dir";
}

function up()
{
    u $@;
    ls;
}

_up()
{
    local cur=${COMP_WORDS[COMP_CWORD]}
    local d=${PWD//\//\ }
    COMPREPLY=( $( compgen -W "$d" -- "$cur" ) )
}
complete -F _up u
complete -F _up up

BASH_MINIMAL_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd -P)"

which ruby > /dev/null && {
    complete -o bashdefault -o default -C $BASH_MINIMAL_DIR/tripleDotDirs.rb cd
    complete -o bashdefault -o default -C $BASH_MINIMAL_DIR/tripleDotFiles.rb mv
    complete -o bashdefault -o default -C $BASH_MINIMAL_DIR/tripleDotFiles.rb cp
    complete -o bashdefault -o default -C $BASH_MINIMAL_DIR/tripleDotFiles.rb ls
    complete -o bashdefault -o default -C $BASH_MINIMAL_DIR/tripleDotFiles.rb ln
}

# fully navigable fwd and back history
function cd.history.clear {
    export BACK_HISTORY=""
    export FORWARD_HISTORY=""
}
cd.history.clear

function cd {
    #BACK_HISTORY=$PWD:$BACK_HISTORY
    BACK_HISTORY="${BACK_HISTORY//$PWD:/}:$PWD"
    FORWARD_HISTORY=""
    builtin cd "$@"
}


function cd.back {
    local to="$1"

    if [ -z "$to" ]; then
        DIR=${BACK_HISTORY##*:}
        if [[ -d "$DIR" ]]; then
            BACK_HISTORY="${BACK_HISTORY%:*}"
            #FORWARD_HISTORY=$PWD:$FORWARD_HISTORY
            FORWARD_HISTORY="$PWD:${FORWARD_HISTORY//$PWD:/}"
            builtin cd "$DIR"
        fi
    else
        #FORWARD_HISTORY=":$PWD${FORWARD_HISTORY}${BACK_HISTORY%:$to*}"
        FORWARD_HISTORY="$PWD:${BACK_HISTORY##*:$to:}${FORWARD_HISTORY}:"
        BACK_HISTORY="${BACK_HISTORY%%:$to*}"
        builtin cd "$to"
    fi
}

function cd.fwd {
    local to="$1"
    if [ -z "$to" ]; then
        DIR=${FORWARD_HISTORY%%:*}
        if [[ -d "$DIR" ]]; then
            FORWARD_HISTORY=${FORWARD_HISTORY#*:}
            #BACK_HISTORY=$PWD:$BACK_HISTORY
            BACK_HISTORY="${BACK_HISTORY//$PWD:/}:$PWD"
            builtin cd "$DIR"
        fi
    else
        cd "$to"
    fi
}

_back()
{
    local cur=${COMP_WORDS[COMP_CWORD]}
    #local d=${BACK_HISTORY//\:/\ }
    local d=${BACK_HISTORY}
    local dd=""

    local ORIG_IFS="$IFS"
    IFS=":"
    for choice in $d; do
        if [[ "$choice" == *"$cur"* ]]; then
            dd="$dd ${choice}"
        fi
    done
    IFS="$ORIG_IFS"

    COMPREPLY=( $( compgen -W "$dd" ) )
}
#complete -o filenames -F _back b
complete -F _back b

_fwd()
{
    local cur=${COMP_WORDS[COMP_CWORD]}
    #local d=${FORWARD_HISTORY//\:/\ }
    local d=${FORWARD_HISTORY}
    local dd=""

    local ORIG_IFS="$IFS"
    IFS=":"
    for choice in $d; do
        if [[ "$choice" == *"$cur"* ]]; then
            dd="$dd ${choice}"
        fi
    done
    IFS="$ORIG_IFS"

    COMPREPLY=( $( compgen -W "$dd" ) )
    #COMPREPLY=( $( compgen -W "$d" -- "$cur" ) )
}
#complete -o filenames -F _fwd f
complete -F _fwd f

function cd.history {
    local RED='\033[0;31m'
    local NC='\033[0m' # No Color

    #reverse BACK_HISTORY for more intuitive display
#    BH=${BACK_HISTORY//\:/\ } 
#
#    local REV=""
#    for h in $BH; do
#       REV="$h:$REV"
#    done

    echo -e "${BACK_HISTORY}:${RED}<<<$PWD>>>${NC}${FORWARD_HISTORY}"
}

function checksums {
    if [ -z "$1" ]; then
        echo "please specify a file to checksum"
        return
    fi
    echo -n "md5: "
    openssl dgst -md5 $1
    echo -n "sha1: "
    openssl dgst -sha1 $1
    echo -n "sha256: "
    openssl dgst -sha256 $1
    echo -n "sha512: "
    openssl dgst -sha512 $1
}

alias f=cd.fwd
alias b=cd.back
alias vi='vim -p'
alias gti='git'
alias curl.kL='curl -k -L'
alias cd.lastargdir='cd $(dirname $_)'

#complete -o default -o nospace -F _git g
complete -o default -o nospace -F _git gti

### note: standard cron unfortunately does not support Year field.  That last asterisk is NOT the year
alias date.cron='date "+%-M %-H %-d %-m * echo hi"'
alias date.cron.4minsfuture='date -v "+4M" "+%-M %-H %-d %-m *"'
alias cron.now='date "+%-M %-H %-d %-m * echo hi"'
