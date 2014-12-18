#include "SystemC.h"

SC_MODULE(output){
	//ports
	sc_in<bool> CLOCK;
	sc_in<bool> reset, clear;
	sc_in<sc_uint<12>> indata;
	sc_out<sc_uint<4>> payload;
	sc_out<sc_uint<8>> count, error;
	
	//processes
	void myoutput();
	SC_CTOR(output){
		
		SC_METHOD(myoutput);
		sensitive<<CLOCK.pos()<<reset<<clear;
	}
};