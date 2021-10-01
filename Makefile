# Specify compiler
CC=gcc

# Specify linker
LINK=gcc

output: main.o
	g++ main.o -o helloworld

main.o: main.cpp
	g++ -c main.cpp

clean:
	rm *.o helloworld