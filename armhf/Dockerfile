FROM resin/armhf-alpine
LABEL maintainer "kapdap.nz@gmail.com"

# 036A9C25BF357DD4 - Tianon Gravi <tianon@tianon.xyz>
#   http://pgp.mit.edu/pks/lookup?op=vindex&search=0x036A9C25BF357DD4
ARG GOSU_VERSION="1.10"
ARG GOSU_ARCHITECTURE="armhf"
ARG GOSU_DOWNLOAD_URL="https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$GOSU_ARCHITECTURE"
ARG GOSU_DOWNLOAD_SIG="https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$GOSU_ARCHITECTURE.asc"
ARG GOSU_DOWNLOAD_KEY="0x036A9C25BF357DD4"

RUN [ "cross-build-start" ]

# Download and install gosu
#   https://github.com/tianon/gosu/releases
RUN buildDeps='curl gnupg' HOME='/root' \
    && set -x \
    && apk add --update $buildDeps \
    && gpg-agent --daemon \
    && gpg --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys $GOSU_DOWNLOAD_KEY \
    && echo "trusted-key $GOSU_DOWNLOAD_KEY" >> /root/.gnupg/gpg.conf \
    && curl -sSL "$GOSU_DOWNLOAD_URL" > gosu-$GOSU_ARCHITECTURE \
    && curl -sSL "$GOSU_DOWNLOAD_SIG" > gosu-$GOSU_ARCHITECTURE.asc \
    && gpg --verify gosu-$GOSU_ARCHITECTURE.asc \
    && rm -f gosu-$GOSU_ARCHITECTURE.asc \
    && mv gosu-$GOSU_ARCHITECTURE /usr/bin/gosu \
    && chmod +x /usr/bin/gosu \
    && apk del --purge $buildDeps \
    && rm -rf /root/.gnupg \
    && rm -rf /var/cache/apk/* \
    ;

RUN [ "cross-build-end" ]