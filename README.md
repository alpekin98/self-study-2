git clone https://github.com/alpekin98/self-study-2.git
cd self-study-cpp
docker-compose up

Jenkins http://192.168.55.10:8080/ adresinde açılmış olacaktır.
Build now tuşuna basın. Build bittiğinde image oluşup hub.docker.com adresine pushlanmış olacaktır.

docker pull alpekin98/demo-repo ile image'ı çekin
docker run alpekin98/demo-repo ile çalıştırın.
Terminal ekranında "Hello World!" yazısı görünecektir.
