ARG BASEIMAGE=python:3.11.0a5-alpine3.15
FROM ${BASEIMAGE}

ARG BUILD_DATE
ARG VCS_REF
ARG VERSION
LABEL mantainer="Eloy Lopez <elswork@gmail.com>" \
    org.label-schema.build-date=$BUILD_DATE \
    org.label-schema.name="mkdocs-diy" \
    org.label-schema.description="mkdocs for amd64 and arm32v7" \
    org.label-schema.url="https://DeftWork.github.io/mkdocs-diy/" \
    org.label-schema.vcs-ref=$VCS_REF \
    org.label-schema.vcs-url="https://github.com/deftwork/mkdocs-diy" \
    org.label-schema.vendor="Deft Work" \
    org.label-schema.version=$VERSION \
    org.label-schema.schema-version="1.0"

RUN pip install mkdocs \
    pygments \
    pymdown-extensions \
    mkdocs-material

WORKDIR /mkdocs

EXPOSE 7777

CMD mkdocs serve