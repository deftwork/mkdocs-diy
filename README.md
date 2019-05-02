# MkDocs-DIY

A [Docker](http://docker.com) file to build images for AMD & ARM devices with a installation of [MkDocs](https://www.mkdocs.org/) that is a fast, simple and downright gorgeous static site generator that's geared towards building project documentation. Documentation source files are written in Markdown, and configured with a single YAML configuration file. [Documentation](https://deftwork.github.io/mkdocs-diy/) for this container is written using itself.

> Be aware! You should read carefully the usage documentation of every tool!

## Thanks to

- [Mkdocs](https://www.mkdocs.org/)
- [Material for MkDocs](https://squidfunk.github.io/mkdocs-material/)
- All the extensions and packages that made this possible.

## Details

- [GitHub](https://github.com/DeftWork/mkdocs-diy)
- [Deft.Work my personal blog](http://deft.work)

| Docker Hub | Docker Pulls | Docker Stars | Docker Build | Size/Layers |
| --- | --- | --- | --- | --- |
| [mkdocs-diy](https://hub.docker.com/r/elswork/mkdocs-diy "elswork/mkdocs-diy on Docker Hub") | [![](https://img.shields.io/docker/pulls/elswork/mkdocs-diy.svg)](https://hub.docker.com/r/elswork/mkdocs-diy "mkdocs-diy on Docker Hub") | [![](https://img.shields.io/docker/stars/elswork/mkdocs-diy.svg)](https://hub.docker.com/r/elswork/mkdocs-diy "mkdocs-diy on Docker Hub") | [![](https://img.shields.io/docker/build/elswork/mkdocs-diy.svg)](https://hub.docker.com/r/elswork/mkdocs-diy "mkdocs-diy on Docker Hub") | [![](https://images.microbadger.com/badges/image/elswork/mkdocs-diy.svg)](https://microbadger.com/images/elswork/mkdocs-diy "mkdocs-diy on microbadger.com") |


## Build Instructions

Build for amd64 or armv7l architecture (thanks to its [Multi-Arch](https://blog.docker.com/2017/11/multi-arch-all-the-things/) base image)

``` sh
docker build -t elswork/mkdocs-diy .
```

## My Real Usage Example

In order everyone could take full advantages of the usage of this docker container, I'll describe my own real usage setup.

``` sh
docker run -d -p 7777:7777 elswork/mkdocs-diy:latest
```

Point your browser to `http://host-ip:7777`
