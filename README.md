# dmoj-judge-docker

build image

docker build --tag dmoj-judge .

build image from scratch

docker build --no-cache --tag dmoj-judge .

run container 

docker run --name=dmoj-judge -t -i -d dmoj-judge /bin/bash

start judge

docker exec dmoj-judge sh /dmoj-judge-docker/docker-entrypoint.sh <site-ip-address> &
