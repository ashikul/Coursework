#include "SystemC.h"
#include <iostream>
#include <fstream>
#include <string>
using namespace std;

template <int buffers>  class controller: public sc_module {
public:
	sc_in<bool> CLOCK;
	sc_out<bool> read[buffers+1];
	sc_out<bool> write[buffers+1];

	SC_HAS_PROCESS(controller);

	controller(sc_module_name name, string filename) : 
	sc_module(name), file(filename){

		inFile.open("control.txt");
		if (inFile.fail()) {
			cerr << "Unable to open file for reading." << endl;
			exit(1);
		}

		inFile >> c;
		for ( int i =0;i<2;i++){
			for ( int j =0;j<16;j++){
				program[i][j] = (int)(c - 48);
				inFile >> c;
			}
		}
		inFile.close();
		x = 0;
		y = 0;

		SC_METHOD(mycontroller);
		sensitive<<CLOCK.pos();
	}

private:
	string file;
	fstream inFile;
	int program[6][17];
	int x;
	int y;
	char c;

	void mycontroller(){

		if(CLOCK.posedge()){

			for(int i = 0; i<buffers+1; i++){
				read[i] = 1;
				write[i] = 1;
			}
		}		
	}


};

