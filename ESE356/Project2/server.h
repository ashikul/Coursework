#include "systemc.h"
#include <iostream>
#include <fstream>
#include <string>
#include "packet.h"
#include "time.h"
#include <cstdlib>
#include <stdio.h>
#include <stdlib.h>
using namespace std;

#pragma once

SC_MODULE(server) {

	//Ports
public:	
	sc_out<bool> free_out;
	sc_out<bool> valid_out;

	sc_in<bool> free_in;
	sc_in<bool> valid_in;
	sc_in<int> in;

	sc_out<int> data[12];
	sc_in<bool> CLOCK;

	//Variables
	int  image;
	int  a[5]; 
	int  b[5];
	int	 o[5000];
	int count;
	packet_type d;
	ifstream infile;
	int HI;
	int LO;
	int WAIT_TIME;
	bool first;

	//Process
	void myserver();
	//SC_HAS_PROCESS(server);
	// Constructor
	SC_CTOR(server) {

		
		HI = 100;
		LO = 1;

		WAIT_TIME = 20;

		count = 0;

		image = 0;
		first = false;

		infile.open("Image.txt");
		for(int i=0 ; i<=4; i++){
			infile >> a[i] >> b[i];
			//cout<<"Intialization "<<"a "<<a[i]<<"b "<<b[i]<<endl;
		}
		infile.close();

		SC_THREAD(myserver);
		sensitive << CLOCK.pos();
		

	}
};