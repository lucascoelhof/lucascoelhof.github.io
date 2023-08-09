#!/usr/bin/env bash

docker run --name lucascoelhof.github.io --env=DEBUG=true --rm --volume="${PWD}:/srv/jekyll" -p 4000:4000 -it jekyll/jekyll:4.2.0 jekyll serve --watch --drafts
