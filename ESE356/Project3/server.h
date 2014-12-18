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

SC_MODULE(server) {
	 
public:	
	//Ports
	sc_in<bool> CLOCK;
	
	sc_in<int> robot_position[3];
	sc_in<bool> collision[3];

	sc_out<bool> robot_stop[3];
	sc_out<int> robot_move_position[3];


	//Variables
	int robot_sequence_counter[3];
	int robot_sequence_size[3];
	bool robot_move_backwards[3];
	int robot_sequence[3][12];
	ifstream infile;

	//Process
	void myserver();

	// Constructor
	SC_CTOR(server) {


		for(int i=0; i<=2; i++){
			robot_sequence_counter[i]=0;
			robot_move_backwards[i] = 0;
		}

		robot_sequence_size[0]=11;
		robot_sequence_size[1]=12;
		robot_sequence_size[2]=8;

		
		infile.open("Robot_Paths.txt");
		//For each robot
		for(int k=0 ; k<3; k++){
			//Load the sequence from test
				for(int i=0 ; i<=robot_sequence_size[k]; i++){
					infile >> robot_sequence[k][i];
					//cout<<"Robot "<<"k "<<k<<"i "<<i<<" data"<<robot_sequence[k][i]<<endl;
		}
		}
		infile.close();
		


		SC_METHOD(myserver);
		sensitive << CLOCK.pos();
		

	}
};