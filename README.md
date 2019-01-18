# dmoj-judge-docker

## build image

```
docker build --tag dmoj-judge .
```

## build image from scratch

```
docker build --no-cache --tag dmoj-judge .
```

## run container and start judge 

```
docker run --privileged --name=dmoj-judge -v /local00/docker-data/dmoj/problems:/problems -t -i -d dmoj-judge <site-ip-address> <judge-name> <judge-key>
```
