# Kali Linux image for pwnable

## Installation

### Pull from Docker Hub

```bash
$ docker pull caphosra/ctf:latest
```

### Build manually

```bash
$ python3 ./build.py ./ctf/ctf
$ docker build -t ctf ./ctf/ctf.gen.dockerfile
```
