FROM kapdap/gnupg AS source

ENV GPG_SIGS="0x036A9C25BF357DD4"

ARG GOSU_VERSION="1.17"

ARG GOSU_URL_DL=https://github.com/tianon/gosu/releases/download/__GOSU_VERSION__/gosu-__GOSU_ARCHITECTURE__
ARG GOSU_ASC_DL=https://github.com/tianon/gosu/releases/download/__GOSU_VERSION__/gosu-__GOSU_ARCHITECTURE__.asc

WORKDIR /app

RUN apk --no-cache add dpkg \
    && gpg-trust \
    && GOSU_ARCHITECTURE=$(dpkg --print-architecture | awk -F- '{ print $NF }') \
    && GOSU_URL=${GOSU_URL_DL/__GOSU_VERSION__/$GOSU_VERSION} \
    && GOSU_URL=${GOSU_URL/__GOSU_ARCHITECTURE__/$GOSU_ARCHITECTURE} \
    && GOSU_ASC=${GOSU_ASC_DL/__GOSU_VERSION__/$GOSU_VERSION} \
    && GOSU_ASC=${GOSU_ASC/__GOSU_ARCHITECTURE__/$GOSU_ARCHITECTURE} \
    && curl -sSL "$GOSU_URL" > gosu \
    && curl -sSL "$GOSU_ASC" > gosu.asc \
    && gpg --verify gosu.asc gosu || { echo "GPG verification failed!"; exit 1; } \
    && rm -f gosu.asc \
    && chmod +x gosu

FROM scratch
LABEL maintainer="kapdap@pm.me"

COPY --from=source /app /bin
