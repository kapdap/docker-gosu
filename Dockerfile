FROM kapdap/gnupg AS source

# 036A9C25BF357DD4 - Tianon Gravi <tianon@tianon.xyz>
#   http://pgp.mit.edu/pks/lookup?op=vindex&search=0x036A9C25BF357DD4
ENV GPG_KEYS="0x036A9C25BF357DD4"

RUN /entrypoint.sh

ARG GOSU_VERSION="1.10"
ARG GOSU_ARCHITECTURES="amd64 arm64 armhf"

WORKDIR /app

COPY base /

RUN chmod +x /*.sh && /download-gosu.sh

FROM scratch
LABEL maintainer "kapdap.nz@gmail.com"

COPY --from=source /app /bin
