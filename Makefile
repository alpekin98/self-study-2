# Specify compiler
CC=gcc

# Specify linker
LINK=gcc

output: main.o
	g++ -c main.cpp
	g++ main.o -o helloworld

clean:
	rm *.o helloworld
	rm -rf helloworld_1.0-1_amd64

make_debian_package:
	ls
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
	# echo 'Depends: nano , curl' >> helloworld_1.0-1_amd64/DEBIAN/control
	dpkg-deb --build --root-owner-group helloworld_1.0-1_amd64
	make clean