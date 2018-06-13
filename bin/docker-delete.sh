#!/bin/bash

set -x

DEBUG=
#DEBUG=echo

# Delete all containers
[ -n "$(docker ps -a -q)" ] && \
  $DEBUG docker rm --force --volumes $(docker ps -a -q)

# Delete all images
[ -n "$(docker images -q)" ] && \
  $DEBUG docker rmi --force $(docker images -q)

# Remove dangling volumes
[ -n "$(docker volume ls -qf dangling=true)" ] && \
  $DEBUG docker volume rm --force $(docker volume ls -qf dangling=true)
