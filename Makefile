# Specify compiler
CC=gcc

# Specify linker
LINK=gcc

build:
	g++ -c main.cpp
	g++ main.o -o helloworld

clean:
	rm *.o helloworld
	rm -rf helloworld_1.0-1_amd64

make_debian_package:
	make build
	rm -rf helloworld_1.0-1_amd64
	mkdir -p helloworld_1.0-1_amd64/usr/local/bin
	cp helloworld helloworld_1.0-1_amd64/usr/local/bin
	mkdir -p helloworld_1.0-1_amd64/DEBIAN
	touch helloworld_1.0-1_amd64/DEBIAN/control
	echo 'Package: helloworld' >> helloworld_1.0-1_amd64/DEBIAN/control
	echo 'Version: 1.0' >> helloworld_1.0-1_amd64/DEBIAN/control
	echo 'Architecture: amd64' >> helloworld_1.0-1_amd64/DEBIAN/control
	echo 'Maintainer: Arinc Alp Eren <arinc.alp.98@gmail.com>' >> helloworld_1.0-1_amd64/DEBIAN/control
	echo 'Description: A program that greets you.' >> helloworld_1.0-1_amd64/DEBIAN/control
	dpkg-deb --build --root-owner-group helloworld_1.0-1_amd64
	make clean
	curl -u arinc.alp.98@gmail.com:AP7y8ekbLckRdzX7RZYYFbU717x -XPUT "https://alpekin98.jfrog.io/artifactory/my-test-debian/pool/helloworld_1.0-1_amd64.deb;deb.distribution=latest;deb.component=main;deb.architecture=amd64" -T ./helloworld_1.0-1_amd64.deb