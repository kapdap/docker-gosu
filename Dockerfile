FROM alpine AS source

ARG GPG_KEYSERVERS="hkp://keyserver.ubuntu.com:80"

# 036A9C25BF357DD4 - Tianon Gravi <tianon@tianon.xyz>
#   http://pgp.mit.edu/pks/lookup?op=vindex&search=0x036A9C25BF357DD4
ARG GOSU_VERSION="1.10"
ARG GOSU_ARCHITECTURES="amd64 aarch64 armhf"
ARG GOSU_KEY="0x036A9C25BF357DD4"

RUN apk --no-cache add -t build-deps curl gnupg \
 && gpg-agent --daemon \
 && gpg --keyserver $GPG_KEYSERVERS --recv-keys $GOSU_KEY \
 && echo "trusted-key $GOSU_KEY" >> /root/.gnupg/gpg.conf

COPY base/001-source /

WORKDIR /app

RUN chmod +x /docker-entrypoint.d/* \
 && chmod +x /docker-entrypoint.sh \
 && /docker-entrypoint.sh

FROM scratch
LABEL maintainer "kapdap.nz@gmail.com"

WORKDIR /app

COPY --from=source /app /app
