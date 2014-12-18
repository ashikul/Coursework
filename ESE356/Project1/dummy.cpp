#include "systemC.h"
#include <string>
#include <iostream>
#include <fstream>
#include "buffer.h"
#include "processing_element.h"
#include "interconnect.h"
#include "controller.h"
#include <cstdlib>
using namespace std;

int sc_main(int argc, char * argv [])
{
		bool read[16], write[16];
		const char* filename = "control.txt";
		fstream inFile(filename);

		if (inFile.fail()) {
			cerr << "Unable to open file for reading." << endl;
			exit(1);
		}

		int program[5][16];
		int i = 0;
		int j = 0;

		char c;
		inFile >> c;
		for ( int i =0;i<2;i++){
			for ( int j =0;j<16;j++){
				program[i][j] = (int)c - 48;
				inFile >> c;
			}
		}
		inFile.close();
				
	 
		for ( int i =0;i<2;i++){
			for ( int j =0;j<16;j++){
				cout << program[i][j];
			}
		}


system("pause");
return 0;
}