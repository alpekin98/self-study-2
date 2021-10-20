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
RUN apk add git
RUN apk update
RUN git clone -q https://github.com/google/googletest.git /googletest && \
 mkdir -p /googletest/build &&\
 cd /googletest/build &&\
 cmake .. &&\
 make && make install &&\
 cd / &&\
# rm -rf /googletest &&\
 echo "hello world"

RUN cp /usr/local/lib/*.a /usr/lib/
# WORKDIR /usr/src/gtest
# RUN cmake CMakeLists.txt
# RUN make
# RUN ["cp",  "*.a", "/usr/lib"]

ENTRYPOINT ["tail", "-f", "/dev/null"]
