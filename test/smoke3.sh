#!/bin/sh
# shellcheck disable=3043

__dir__=$(dirname "$(readlink -f "$0")")
spinner="$__dir__"/../spinner

clean() { $spinner clean; }
trap 'clean; exit 1' 1 2 15

slow() {
    sleep 1
    pv -q -L 100 < "$src"
}

readline() {
    local spinner_status read_status

    $spinner start
    spinner_status=$?

    IFS= read -r line
    read_status=$?

    $spinner stop $spinner_status

    printf "\n%s" "$line"

    [ $read_status = 0 ] && readline
}

src="$__dir__"/$0

[ "$1" ] && {
    pgid=`ps -o pgid= -p $$ | xargs`
    timer=`shuf -i 1-9 -n 1`

    echo "timer $timer for $pgid group"
    ( sleep "$timer"; echo '*** SIGTERM ***' 1>&2; kill -2 -"$pgid" ) &
}

slow | readline
