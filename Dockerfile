FROM ubuntu:xenial
USER root

LABEL version="1.0"
LABEL Name="main-docker-agent"

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