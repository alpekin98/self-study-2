FROM docker
USER root

LABEL version="1.0"
LABEL Name="compile-dockerfile"

RUN apk update
RUN apk add make
RUN apk add g++ -y
RUN apk update