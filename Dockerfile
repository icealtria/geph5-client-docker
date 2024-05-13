FROM rust:latest as builder

RUN \ 
    apt update && apt install -y \
    gcc clang g++ zlib1g-dev libmpc-dev curl \
    libmpfr-dev libgmp-dev  build-essential

RUN rustup target add $(uname --machine)-unknown-linux-musl

RUN git clone https://github.com/geph-official/geph5 --depth 1
WORKDIR /geph5
RUN cargo build --release --locked --target $(uname --machine)-unknown-linux-musl -p geph5-client


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
