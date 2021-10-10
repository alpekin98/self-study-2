FROM docker
USER root

LABEL version="1.0"
LABEL Name="compile-dockerfile"

RUN apt-get update -y
RUN apt-get install make
RUN apt-get install g++ -y
RUN apt-get update