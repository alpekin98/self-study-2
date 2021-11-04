FROM ubuntu:xenial
USER root

LABEL version="1.0"
LABEL Name="main-docker-agent"

RUN apt update
RUN apt-get install curl nano -y
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
RUN echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu xenial stable" > /etc/apt/sources.list.d/docker.list
RUN apt-get install -y apt-transport-https
RUN apt-get update 

RUN apt install -y  docker-ce-cli\
                    gcc\
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