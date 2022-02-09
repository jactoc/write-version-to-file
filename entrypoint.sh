#!/bin/sh
set -eo pipefail

error() {
    echo -e "\x1b[1;31m$1\e[0m $2"
}

log() {
    echo -e "\x1b[1;32m$1\e[0m $2"
}

filename=$1

log "File Name:" "$filename"

if [ -z "$2" ]; then
    placeholder="\${VERSION}"
else
    placeholder=$2
fi

log "Placeholder:" "$placeholder"

if test -f $filename; then
    content=$(cat "$filename")
    log "File Content:" "$content"
else
    error "Version file not found! Looked for:" "$filename"
    exit 1;
fi

if test -r $filename -a -w $filename, echo $? = 0; then
    git fetch --tags --force
    latestVersionTag=$(git describe --tags "$(git rev-list --tags --max-count=1)")
    
    log "Replacing placeholder with:" "$latestVersionTag"

    echo "$latestVersionTag" > "$filename"

    log "Updated File Content:" "$content"
else
    error "Cannot write on " "$filename"
    exit 1;
fi
