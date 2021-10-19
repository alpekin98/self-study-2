FROM docker
USER root

LABEL version="1.0"
LABEL Name="compile-dockerfile"

RUN apk update
RUN apk add make
RUN apk add build-base
RUN apk add dpkg
RUN apk add curl
RUN apk add gtest-dev
RUN apk add cmake
RUN apk update
# WORKDIR /usr/src/gtest
# RUN cmake CMakeLists.txt
# RUN make
# RUN ["cp",  "*.a", "/usr/lib"]

ENTRYPOINT ["tail", "-f", "/dev/null"]
