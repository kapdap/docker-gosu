# gosu Docker

[![Published](https://github.com/kapdap/docker-gosu/actions/workflows/publish.yaml/badge.svg)](https://github.com/kapdap/docker-gosu/actions/workflows/publish.yaml)
[![GitHub](https://img.shields.io/badge/GitHub-grey)](https://github.com/kapdap/docker-gosu)
[![Docker Hub](https://img.shields.io/badge/Docker_Hub-blue)](https://hub.docker.com/r/kapdap/gosu)

This repository contains a Docker image for [gosu](https://github.com/tianon/gosu).

## Quickstart

```dockerfile
FROM kapdap/gosu AS gosu
FROM alpine

COPY --from=gosu /bin/gosu /bin/

RUN adduser -D -H -u 1000 app

CMD ["gosu", "1000", "whoami"]
```