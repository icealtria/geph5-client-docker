FROM rust:latest as builder

ENV CROSS_CONTAINER_IN_CONTAINER=true
RUN cargo install cross

RUN git clone https://github.com/geph-official/geph5 --depth 1
RUN cd geph5 && cross build --release --locked --target $(uname --machine)-unknown-linux-musl -p geph5-client


FROM alpine:latest

RUN apk add --no-cache envsubst

COPY --from=builder /geph5/target/*-unknown-linux-musl/release/geph5-client /geph5-client

RUN mkdir -p /config

ARG USERNAME
ARG PASSWORD
ARG EXIT

COPY config.template /config.template

ENV XDG_CONFIG_HOME=/config

EXPOSE 9999
EXPOSE 19999

ENTRYPOINT ["sh", "-c", "envsubst < /config.template > /config/config.yml && /geph5-client -c /config/config.yml"]
