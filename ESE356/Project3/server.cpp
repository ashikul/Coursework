#include "server.h"




void server::myserver(){
		
	
		if(CLOCK.posedge()){
		

			//move robot
			for(int i=0; i<=2; i++){
				robot_move_position[i] = robot_sequence[i][robot_sequence_counter[i]]; 
			}

			//move robot_sequence
			for(int i=0; i<=2; i++){
				if(robot_move_backwards[i]==0){ //move forward
				robot_sequence_counter[i] = robot_sequence_counter[i] + 1;
				} else { //movebackwards
				robot_sequence_counter[i] = robot_sequence_counter[i] - 1;
				}

				if(robot_sequence_counter[i] == robot_sequence_size[0]+1){ //if end of sequence
				robot_move_backwards[i] = 1; //movebackwards
				} 
				if (robot_sequence_counter[i] == 0){ //if start of sequence
				robot_move_backwards[i] = 0; //moveforward
				}

			}

			for(int i=0; i<=2; i++){
				if(robot_position[i].read() != robot_sequence[i][robot_sequence_counter[i]]){
					robot_stop[i] = 1;
					wait(25, SC_NS);

				} else
					robot_stop[i] = 0;

			}




		}


	 
};