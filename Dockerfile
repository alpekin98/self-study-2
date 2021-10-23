FROM ubuntu:xenial
USER root

LABEL version="1.0"
LABEL Name="main-docker-agent"

ARG VERSION = 1.0
ARG REV_NUMBER = 1
ARG DEB_ARCHITECTURE = amd64
ARG FILE_REPO_SERVER = TODO

RUN apt update
RUN apt install -y  gcc\
                    libgtest-dev\
                    curl\
                    dpkg\
                    git\
                    make\
                    tzdata\
                    cmake\
                    build-essential\
                    fakeroot

WORKDIR /usr/src/gtest
RUN cmake CMakeLists.txt

RUN make
RUN cp *.a /usr/lib