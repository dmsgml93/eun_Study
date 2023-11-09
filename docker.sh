#!/bin/sh

docker build --progress=plain --no-cache -t test3 .

docker run --name sample -p 3000:3000 test3

docker rm sample