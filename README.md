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
docker run --name=dmoj-judge -t -i -d dmoj-judge <site-ip-address>
```
