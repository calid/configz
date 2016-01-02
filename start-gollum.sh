#!/bin/bash

# Usage: start-gollum [ wiki-root [host [port] ] ]

wiki_root="${1-./}"
host="${2-localhost}"
port="${3-0}"

log="$HOME/var/gollum_$$.log"

mkdir -p $HOME/var

gollum \
    --host $host --port $port \
    --adapter rugged \
    --show-all \
    --mathjax \
    --user-icons gravatar \
    "$wiki_root" &>$log &

port=""
while test -z "$port"; do
    port=$(grep -hPo 'port=\d+' $log | sed 's/port=//')
    sleep 1
done

pid=$(grep -hPo 'pid=\d+' $log | sed 's/pid=//')
echo "pid=$pid port=$port"
firefox http://${host}:${port} &>/dev/null &
