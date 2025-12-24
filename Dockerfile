FROM alpine:latest

RUN \
    apk update \
    && apk add --no-cache ca-certificates gettext \
    && rm -rf /var/cache/apk/*

COPY geph5-client /geph5-client

RUN mkdir -p /config

ENV XDG_CONFIG_HOME=/config

EXPOSE 9909
EXPOSE 9910

ENTRYPOINT ["sh", "-c", "/geph5-client -c /config.yml"]
