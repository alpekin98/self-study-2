#ifndef SAYS_HELLO_WORLD
#define SAYS_HELLO_WORLD
#include <iostream>
#include <stdlib.h>
#include <time.h> 
class SaysHelloWorld {
	public:
		void sayHelloWorld(){
			std::cout << "I Say Hello World!" << std::endl;
		}
		void printRandomNumber(){
			srand (time(NULL));
			std::cout << "Random Number: " << rand() % 10 + 1 << std::endl;
		}
};

#endif
