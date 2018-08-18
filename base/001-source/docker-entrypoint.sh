#!/bin/sh

set -x

# Flexible docker entrypoint scripts adapted from
# https://www.camptocamp.com/en/actualite/flexible-docker-entrypoints-scripts/

DIR=/docker-entrypoint.d

if [ -d "$DIR" ]; then
  /bin/run-parts "$DIR"
fi
