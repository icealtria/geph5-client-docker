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