# FROM docker
# USER root

# LABEL version="1.0"
# LABEL Name="compile-dockerfile"

# RUN apk update
# RUN apk add make
# RUN apk add build-base
# RUN apk add dpkg
# RUN apk add curl
# RUN apk add gtest-dev
# RUN apk add cmake
# RUN apk add git
# RUN apk update

# ENTRYPOINT ["tail", "-f", "/dev/null"]

FROM ubuntu:xenial
USER root

LABEL version="1.0"
LABEL Name="main-docker-agent"

ARG VERSION = "1.0"
ARG REV_NUMBER = "1"
ARG EXECUTABLE_PATH = "/opt/cinar/amf/cnramf-coremgr"
ARG DEB_ARCHITECTURE = "amd64"

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