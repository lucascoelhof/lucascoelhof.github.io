#!/usr/bin/env bash

docker run --name lucascoelhof.github.io --env=DEBUG=true --rm --volume="${PWD}:/srv/jekyll" -p 4000:4000 -it jekyll/jekyll:3.8.5 jekyll serve --watch --drafts
