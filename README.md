# mongo-golang

## required
- Golang binary
- Mongodb
- Docker (optional)

## Running

### Docker CLI
```
$ docker run --network=mongoNet -p 9000:9000 --rm -it $(docker build -q .)
```

### Docker Compose
```
$ docker compose up -d
```
