#!/usr/bin/env bash

docker run --env=DEBUG=true --rm --volume="${PWD}:/srv/jekyll" -it jekyll/jekyll:3.8.5 jekyll build
