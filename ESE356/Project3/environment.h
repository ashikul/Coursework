#include "systemc.h"
#include <iostream>
#include <fstream>
#include <string>
#include "time.h"
#include <cstdlib>
using namespace std;

#pragma once

SC_MODULE(environment) {

	//Ports
	sc_in<bool> CLOCK;
	sc_in<int> robot_position[3];

	sc_out<bool> collision[3];

	//Variables
	int grid[36];
	bool grid_occupied[36];
	ifstream infile;

	int person_sequence_counter[3];
	int person_sequence_size[3];
	bool person_move_backwards[3];
	int person_sequence[3][12];

	//Process
	void myenvironment();

	// Constructor
	SC_CTOR(environment) {
		
		for(int i=0; i<=2; i++){
			person_sequence_counter[i]=0;
			person_move_backwards[i] = 0;
		}

		person_sequence_size[0]=22;
		person_sequence_size[1]=22;
		person_sequence_size[2]=30;

		infile.open("person_Paths.txt");
		//For each person
		for(int k=0 ; k<3; k++){
			//Load the sequence from test
				for(int i=0 ; i<=person_sequence_size[k]; i++){
					infile >> person_sequence[k][i];
					//cout<<"person "<<"k "<<k<<"i "<<i<<" data"<<person_sequence[k][i]<<endl;
		}
		}
		infile.close();
		





		SC_METHOD(myenvironment); 
		sensitive << CLOCK.pos();

	}
};