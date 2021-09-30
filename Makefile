# Specify compiler
CC=gcc

# Specify linker
LINK=gcc

output: main.o
	g++ main.o -o output

main.o: main.cpp
	g++ -c main.cpp

clean:
	rm *.o output