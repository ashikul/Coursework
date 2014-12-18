//8 processing elements

#include "SystemC.h"
#include "processing_element.h"

template<int inputs, int outputs, int L>
void processing_element::myprocessing_element(){
	if(CLOCK.posedge()){

		sc_int<16> tempout1;
		sc_int<16> tempout2;

		if (inputs==1)&&(outputs==1){
			//operation
			#include "func1.txt"
				

			//latency
			internal1[1] = tempout1;
			for(i=2;i<L;i++){
				internal1[i] = internal1[i-1];
			}

			//output
			out1 = internal1[L];
		}


		if (inputs==2)&&(outputs==1){
			//operation
			#include "func1.txt"
				

			//latency
			internal1[1] = tempout1;
			for(i=2;i<L;i++){
				internal1[i] = internal1[i-1];
			}
			internal2[1] = tempout2;
			for(i=2;i<L;i++){
				internal2[i] = internal2[i-1];
			}

			//output
			out1 = internal1[L];
		}
		if (inputs==1)&&(outputs==2){
			//operation
			#include "func1.txt"
				

			//latency
			internal1[1] = tempout1;
			for(i=2;i<L;i++){
				internal1[i] = internal1[i-1];
			}

			//output
			out1 = internal1[L];
			out2 = internal1[L];
		}
		if (inputs==2)&&(outputs==2){
			//operation
			#include "func1.txt"
				

			//latency
			internal1[1] = tempout1;
			for(i=2;i<L;i++){
				internal1[i] = internal1[i-1];
			}
			internal2[1] = tempout2;
			for(i=2;i<L;i++){
				internal2[i] = internal2[i-1];
			}

			//output
			out1 = internal1[L];
			out2 = internal2[L];
		}
		

		
	}
}



