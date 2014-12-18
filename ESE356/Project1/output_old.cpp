#include "SystemC.h"
#include "output_old.h"

void output::myoutput(){
	
	if(CLOCK.posedge()){

		sc_uint<12> data;

		data = indata.read();
	
		if(!reset) {
			//all inputs and outs to 0
			data = 0;
			payload = 0;
			count = 0;
			error = 0;		
		}
 

		if(clear){
			//outputs to 0
			payload = 0;
			count = 0;
			error = 0;
		}

		//check last 4 bits for 'type 1'
		if(data.range(11,8)==1){
			payload = data.range(7,4);
			count = count.read() + 1;

			//check if even parity
			if (data[0] != 1){
				error = error.read() + 1;
			}
		}

	}

}

	

