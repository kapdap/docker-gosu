#!/bin/sh

if [ ! -z "$DEBUG" ]; then
    set -x
fi

for GOSU_ARCHITECTURE in ${GOSU_ARCHITECTURES// / }; do
    GOSU_URL="https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$GOSU_ARCHITECTURE"
    GOSU_SIG="https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$GOSU_ARCHITECTURE.asc"

    echo "Downloading gosu v$GOSU_VERSION for $GOSU_ARCHITECTURE architecture"

    curl -sSL "$GOSU_URL" > gosu-$GOSU_ARCHITECTURE
    curl -sSL "$GOSU_SIG" > gosu-$GOSU_ARCHITECTURE.asc
    gpg --verify gosu-$GOSU_ARCHITECTURE.asc
    rm -f gosu-$GOSU_ARCHITECTURE.asc
    chmod +x gosu-$GOSU_ARCHITECTURE
done
