#include "SystemC.h"
#include "buffer.h"

template <int M, unsigned D>
void buffer::mybuffer(){

	out2 = 0;
	out1 = 0;

	if(CLOCK.posedge()){

		if(start_write.posedge()){


			//i`nc pointer
			current_write_count = current_write_count +1;
			counter = counter + 1;
			
			//check direction
			if(D=="01" || D=="11"){
				//write out2
				//out2 = Memory[current_write_count];
				out2.write(Memory[current_write_count]);
			} else {
				//write out1
				out1 =Memory[current_write_count];
			}


		}
		
		if(start_read.posedge()){

			//inc pointer
			current_read_count = current_read_count +1;
			
			//check direction
			if(D=="10" || D=="11"){
				//read in2
				Memory[current_read_count] = in2.read();
			} else {
				//read in1
				Memory[current_read_count] = in1.read();
			}
			



		}

	}
}

	

