FROM kapdap/gnupg AS source

ENV GPG_SIGS="0x036A9C25BF357DD4"

RUN gpg-trust

COPY base /

RUN chmod +x *.sh

WORKDIR /app

ARG GOSU_URL_DL=https://github.com/tianon/gosu/releases/download/__GOSU_VERSION__/gosu-__GOSU_ARCHITECTURE__
ARG GOSU_ASC_DL=https://github.com/tianon/gosu/releases/download/__GOSU_VERSION__/gosu-__GOSU_ARCHITECTURE__.asc

ARG GOSU_ARCHITECTURES="amd64 arm64 armhf"
ARG GOSU_VERSION="1.10"

RUN /download-gosu.sh

FROM scratch
LABEL maintainer "kapdap.nz@gmail.com"

COPY --from=source /app /bin
