#include "SystemC.h"

template <int flag>  class interconnect : public sc_module {

public:
	sc_in<bool> CLOCK;
	sc_in<sc_int<16> > in[20];
	sc_out<sc_int<16> > out[20];

	SC_HAS_PROCESS(interconnect);

	interconnect(sc_module_name name, string filename) : 
	sc_module(name), file(filename){

		SC_METHOD(myinterconnect);
		sensitive<<CLOCK.pos();
	}

private:
	string file;


///////////////////////////////////////////////////////////////

	void myinterconnect(){
		
	

	if(CLOCK.posedge()){
	
		if(flag == 1){
			out[10] = in[1].read();
			out[0] = in[11].read();
			out[3] = in[12].read();
			out[14] = in[5].read();
			out[16] = in[7].read();
			out[6] = in[17].read();
		}
		if(flag == 2){
			out[10] = in[0].read();
			out[1] = in[16].read();
			out[2] = in[12].read();
			out[14] = in[3].read();
			out[15] = in[4].read();
			out[5] = in[13].read();
			out[11] = in[6].read();
			out[17] = in[7].read();
			out[8] = in[18].read();
			out[9] = in[19].read();

		}




	}
	
		
	
	}
////////////////////////////////////////////////


};