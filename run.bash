#!/usr/bin/env bash

docker run --name $(cat ${PWD}/CNAME | tr -d "[:space:]") --env=DEBUG=true --rm --volume="${PWD}:/srv/jekyll" -p 3000:4000 -it jekyll/jekyll:3.8.5 jekyll serve --watch --drafts
