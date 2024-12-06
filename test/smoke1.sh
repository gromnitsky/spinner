#!/bin/sh

__dir__=$(dirname "$(readlink -f "$0")")
spinner=$__dir__/../spinner

clean() { $spinner clean; }
trap 'clean; exit 1' 1 2 15

echo start

$spinner start
spinner_status=$?

sleep 3

$spinner stop $spinner_status

sleep 1
echo stop
