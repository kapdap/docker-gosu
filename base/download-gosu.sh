#!/bin/sh

if [ ! -z "$DEBUG" ]; then
    set -x
fi

GOSU_ARCHITECTURES=${GOSU_ARCHITECTURES:-$GOSU_ARCHITECTURE}

for GOSU_ARCHITECTURE in ${GOSU_ARCHITECTURES//+( )/ }; do
    GOSU_URL=${GOSU_URL_DL/__GOSU_VERSION__/$GOSU_VERSION}
    GOSU_URL=${GOSU_URL/__GOSU_ARCHITECTURE__/$GOSU_ARCHITECTURE}

    GOSU_ASC=${GOSU_ASC_DL/__GOSU_VERSION__/$GOSU_VERSION}
    GOSU_ASC=${GOSU_ASC/__GOSU_ARCHITECTURE__/$GOSU_ARCHITECTURE}

    echo "Downloading gosu v$GOSU_VERSION for $GOSU_ARCHITECTURE from $GOSU_URL"

    curl -sSL "$GOSU_URL" > gosu-$GOSU_ARCHITECTURE \
        && curl -sSL "$GOSU_ASC" > gosu-$GOSU_ARCHITECTURE.asc \
        && gpg --verify gosu-$GOSU_ARCHITECTURE.asc &>/dev/null \
        && rm -f gosu-$GOSU_ARCHITECTURE.asc \
        && chmod +x gosu-$GOSU_ARCHITECTURE \
        && continue

    echo "Error: Failed to download gosu v$GOSU_VERSION for $GOSU_ARCHITECTURE from $GOSU_URL"

    rm -f gosu-$GOSU_ARCHITECTURE &>/dev/null
    rm -f gosu-$GOSU_ARCHITECTURE.asc &>/dev/null
done
