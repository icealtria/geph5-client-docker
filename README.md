# geph5-client-docker

CLI
```sh
docker run -d \
  -p 19999:19999 \
  -p 9999:9999 \
  -e SECRET=12345678 \
  -e EXIT=FR \
  -e PASSTHROUGH_CHINA=true \
  icealtria/geph5-client:latest
```
Docker Compose
```yml
services:
  geph5:
    image: icealtria/geph5-client:latest
    ports:
      - "19999:19999"
      - "9999:9999"
    environment:
      SECRET: "12345678"
      EXIT: FR
      PASSTHROUGH_CHINA: true
```