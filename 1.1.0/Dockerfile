FROM debian:bullseye-slim

LABEL maintainer.0="pepeenthusiast (@pepeenthusiast)"

RUN useradd -r pepecoin \
  && apt-get update -y \
  && apt-get install -y curl gnupg gosu \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ARG TARGETPLATFORM
ENV PEPECOIN_VERSION=1.1.0
ENV PEPECOIN_DATA=/home/pepecoin/.pepecoin
ENV PATH=/opt/pepecoin-${PEPECOIN_VERSION}/bin:$PATH

RUN set -ex \
  && if [ "${TARGETPLATFORM}" = "linux/amd64" ]; then export TARGETPLATFORM=x86_64-linux-gnu; fi \
  && if [ "${TARGETPLATFORM}" = "linux/arm64" ]; then export TARGETPLATFORM=aarch64-linux-gnu; fi \
  && if [ "${TARGETPLATFORM}" = "linux/arm/v7" ]; then export TARGETPLATFORM=arm-linux-gnueabihf; fi \
  && curl -SLO https://github.com/pepecoinppc/pepecoin/releases/download/v${PEPECOIN_VERSION}/pepecoin-${PEPECOIN_VERSION}-${TARGETPLATFORM}.tar.gz \
  && tar -xzf *.tar.gz -C /opt \
  && rm *.tar.gz \
  && rm -rf /opt/pepecoin-${PEPECOIN_VERSION}/bin/pepecoin-qt

COPY docker-entrypoint.sh /entrypoint.sh

RUN chmod +x entrypoint.sh

VOLUME ["/home/pepecoin/.pepecoin"]

EXPOSE 33873 33874 44873 44874 18332 18444


ENTRYPOINT ["/entrypoint.sh"]

RUN pepecoind -version | grep "Pepecoin Core Daemon version v${PEPECOIN_VERSION}"

CMD ["pepecoind"]
