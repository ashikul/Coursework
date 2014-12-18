#include "environment.h"

void environment::myenvironment(){

if(CLOCK.posedge()){
		

			 
			for(int i=0; i<=2; i++){

				 
				
				//check collision
				for(int i=0; i<=2; i++){
					if(grid[36] == robot_position[i].read()){
						collision[i] = 1;

					}	else {

						collision[i] = 0;

					}

				}

				//move person
				grid[36] = person_sequence[i][person_sequence_counter[i]]; 

			}



			//move person_sequence
			for(int i=0; i<=2; i++){
				if(person_move_backwards[i]==0){ //move forward
				person_sequence_counter[i] = person_sequence_counter[i] + 1;
				} else { //movebackwards
				person_sequence_counter[i] = person_sequence_counter[i] - 1;
				}

				if(person_sequence_counter[i] == person_sequence_size[0]+1){ //if end of sequence
				person_move_backwards[i] = 1; //movebackwards
				} 
				if (person_sequence_counter[i] == 0){ //if start of sequence
				person_move_backwards[i] = 0; //moveforward
				}

			}

			//for(int i=0; i<=36; i++){
			//	if(grid_occupied[36]==1){
			//		
			//		wait(25, SC_NS);
			//	} else
 

			//} 




}
};