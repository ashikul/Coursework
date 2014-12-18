#include "systemc.h"
#include <iostream>
#include <fstream>
#include <string>
#include "time.h"
#include <cstdlib>
#include <stdio.h>
#include <stdlib.h>
using namespace std;

#pragma once

SC_MODULE(robot) {
 
public:	
    //Ports
	sc_in<bool> CLOCK;
	sc_in<int> robot_position_in[3];
	
	sc_out<int> robot_position_out[3];

	//Variables
	int robot_position[3];

	//Process
	void myrobot();

	// Constructor
	SC_CTOR(robot) {

		for(int i=0; i<=2; i++){
			robot_position[i]=0;
		}

		SC_METHOD(myrobot);
		sensitive << CLOCK.pos();
		

	}
};