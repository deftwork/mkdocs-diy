ARG BASEIMAGE=python:alpine
FROM ${BASEIMAGE}

ARG BUILD_DATE
ARG VCS_REF
ARG VERSION
LABEL mantainer="Eloy Lopez <elswork@gmail.com>" \
    org.opencontainers.image.title=mkdocs-diy \
    org.opencontainers.image.description="My Multiarch Mkdocs Docker recipe" \
    org.opencontainers.image.vendor=Deft.Work \
    org.opencontainers.image.url=https://deft.work/mkdocs \
    org.opencontainers.image.source=https://github.com/deftwork/mkdocs-diy \
    org.opencontainers.image.version=$VERSION \ 
    org.opencontainers.image.created=$BUILD_DATE \
    org.opencontainers.image.revision=$VCS_REF \
    org.opencontainers.image.licenses=MIT

RUN pip install mkdocs \
    pygments \
    pymdown-extensions \
    mkdocs-material

WORKDIR /mkdocs

EXPOSE 7777

CMD mkdocs serve