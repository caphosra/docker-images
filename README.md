# Personal collection of Docker images

[![Deployment](https://github.com/caphosra/docker-images/actions/workflows/deployment.yml/badge.svg)](https://github.com/caphosra/docker-images/actions/workflows/deployment.yml)

This repository contains Docker images, which I have used for general purposes. I would be happier if those images helped you to skip your tiresome and confusing setups.

Of course, posting an issue or making a PR is welcome.

|Image|Description|README|Size|
|:---|:---|:---|:---:|
|`caphosra/ctf`|For CTF, especially for pwnable|[ctf](https://github.com/caphosra/docker-images/tree/main/ctf)|[![Docker Image Size (tag)](https://img.shields.io/docker/image-size/caphosra/ctf/latest)](https://hub.docker.com/r/caphosra/ctf)|
|`caphosra/haskell`|GHC, cabal, stack and hls included|[haskell](https://github.com/caphosra/docker-images/tree/main/haskell)|[![Docker Image Size (tag)](https://img.shields.io/docker/image-size/caphosra/haskell/latest)](https://hub.docker.com/r/caphosra/haskell)|
|`caphosra/ubuntu`|Non-root Ubuntu|[non-root](https://github.com/caphosra/docker-images/tree/main/non-root)|[![Docker Image Size (tag)](https://img.shields.io/docker/image-size/caphosra/ubuntu/20.04)](https://hub.docker.com/r/caphosra/ubuntu)|

## How to build

Since Docker files in this repository are split into fragments, you cannot build the images without combining them. To compile the images, you should run the following command. Then, you'll find `[file name].gen.dockerfile`, which are valid Docker files.
```bash
$ python3 ./build.py
```

If you don't need all files, you can specify the file to be compiled.
```bash
$ python3 ./build.py [path to the file without its extension]
```

If you want to delete generated files, please run the following command.
```bash
$ python3 ./build.py clean
```
