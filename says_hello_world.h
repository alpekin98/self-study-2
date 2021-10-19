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
		int printRandomNumber(){
			srand (time(NULL));
			int randomNumber = rand() % 10 + 1;
			std::cout << "Random Number: " << randomNumber << std::endl;
			return randomNumber;
		}
};

#endif
