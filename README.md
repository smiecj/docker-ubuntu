# docker-ubuntu
ubuntu basic image and some service image, like [docker-centos](https://github.com/smiecj/docker-centos)

## structure
- Dockerfiles
- system
  - basic image
- net
  - xrdp: for remote desktop

## usage
most image will upload to dockerhub, you can set arg: REPO=mzsmieli to pull from my repo, for example:

```shell
# run ubuntu base
REPO=mzsmieli make run_base
```

## images
|  type   | component/image name  | build command | run command | feature
|  ----  | ---- | ---- | ---- | ---- |
| basic  | base | make build_base | make run_base | ubuntu, [s6](https://github.com/just-containers/s6-overlay), [oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh)  |
| net  | xrdp | make build_xrdp | make run_xrdp | xrdp