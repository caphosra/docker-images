# Haskell

Haskell environment on Ubuntu 20.04.

Installed softwares:
|Name|Version|
|:---|:---|
|cabal|3.10.1.0|
|GHC|9.4.5|
|haskell language server|2.0.0.0|
|stack|2.11.1|

## Installation

### Pull from Docker Hub

```bash
$ docker pull caphosra/haskell:latest
```

### Build manually

```bash
$ python3 ./build.py ./haskell/haskell
$ docker build -t haskell --build-arg UBUNTU_VERSION=20.04 ./haskell/haskell.gen.dockerfile
```
