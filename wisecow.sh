#!/usr/bin/env bash

SRVPORT=4499
RSPFILE=response

rm -f $RSPFILE
mkfifo $RSPFILE

get_api() {
    read line
    echo $line
}

handleRequest() {
    get_api
    mod=$(/usr/games/fortune)

    cat <<EOF > $RSPFILE
HTTP/1.1 200 OK

<pre>`/usr/games/cowsay "$mod"`</pre>
EOF
}

prerequisites() {
    if [ ! -f "/usr/games/cowsay" ] || [ ! -f "/usr/games/fortune" ]; then
        echo "Install prerequisites."
        exit 1
    fi
}

main() {
    prerequisites
    echo "Wisdom served on port=$SRVPORT..."

    while true; do
        cat $RSPFILE | nc -lN $SRVPORT | handleRequest
        sleep 1  # Prevent high CPU usage & resource exhaustion
    done
}

main

