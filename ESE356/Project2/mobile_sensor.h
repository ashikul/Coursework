#include "systemc.h"
#include <iostream>
#include <fstream>
#include <string>
#include "packet.h"
#include "time.h"
#include <cstdlib>
using namespace std;

#pragma once

SC_MODULE(mobile_sensor) {

	//Ports
	sc_in<int> data[12];
	sc_in<bool> free_in;
	sc_in<bool> valid_in;

	sc_out<int> out;
	sc_out<bool> free_out;
	sc_out<bool> valid_out;

	sc_in<bool> CLOCK;

	//Variables
	int  x[1000];
	int  y[1000];
	int  j;
	int  counter;
	int  image;
	int	 a[5];
	int  b[5];
	packet_type d;
	ifstream infile;
	int WAIT_TIME;

	//Process
	void mymobile_sensor();
	//SC_HAS_PROCESS(mobile_sensor);
	// Constructor
	SC_CTOR(mobile_sensor) {
		
		
		infile.open("SensorData.txt");
		for(int i=0; i<1000; i++){
		infile >> x[i] >> y[i];
		}
		infile.close();

		counter = 0;
		WAIT_TIME = 20;

		SC_THREAD(mymobile_sensor); 
		sensitive << CLOCK.pos();

	}
};