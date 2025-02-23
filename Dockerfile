FROM alpine:latest

RUN \
    apk update \
    && apk add --no-cache ca-certificates gettext \
    && rm -rf /var/cache/apk/*

COPY /geph5/target/release/geph5-client /geph5-client

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
