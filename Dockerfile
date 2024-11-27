FROM rust:latest as builder

RUN git clone https://github.com/geph-official/geph5 --depth 1
RUN cd geph5 && cargo build --release --locked  -p geph5-client

FROM debian:stable-slim

RUN \
    apt-get update \
    && apt-get -y install ca-certificates gettext-base \
    && apt-get clean \
    && rm -rf \
    /tmp/* \
    /var/lib/apt/lists/* \
    /var/tmp/*

COPY --from=builder /geph5/target/release/geph5-client /geph5-client

RUN mkdir -p /config

ARG USERNAME
ARG PASSWORD
ARG EXIT
ARG PASSTHROUGH_CHINA=false
ENV PASSTHROUGH_CHINA=${PASSTHROUGH_CHINA}

COPY config.template /config.template

ENV XDG_CONFIG_HOME=/config

EXPOSE 9999
EXPOSE 19999

ENTRYPOINT ["sh", "-c", "envsubst < /config.template > /config/config.yml && /geph5-client -c /config/config.yml"]
