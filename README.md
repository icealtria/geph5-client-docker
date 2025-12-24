# geph5-client-docker

CLI
```sh
docker run -d \
  -p 9909:9909 \
  -p 9910:9910 \
  -v $(pwd)/config.yml:/config.yml \
  icealtria/geph5-client:latest
```
Docker Compose
```yml
services:
  geph5:
    image: icealtria/geph5-client:latest
    ports:
      - "9909:9909"
      - "9910:9910"
    volumes:
      - ./config.yml:/config.yml
```

Config
```yml
socks5_listen: 0.0.0.0:9909
http_proxy_listen: 0.0.0.0:9910

passthrough_china: false

exit_constraint: auto

# exit_constraint:
#  country: NL

broker:
  race:
    - fronted:
        front: https://www.cdn77.com/
        host: 1826209743.rsc.cdn77.org
    - fronted:
        front: https://vuejs.org/
        host: svitania-naidallszei-2.netlify.app
    - aws_lambda:
        function_name: geph-lambda-bouncer
        region: us-east-1
        obfs_key: 855MJGAMB58MCPJBB97NADJ36D64WM2T:C4TN2M1H68VNMRVCCH57GDV2C5VN6V3RB8QMWP235D0P4RT2ACV7GVTRCHX3EC37

credentials:
  secret: "your-account-secret"

sess_metadata:
  filter:
    ads: false # Enable ad filtering.
    nsfw: false # Enable NSFW content filtering.

vpn: false
```