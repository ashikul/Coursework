#include "robot.h"




void robot::myrobot(){

	if(CLOCK.posedge()){

		for(int i=0; i<=2; i++){
		robot_position[i] = robot_position_in[i].read();
		robot_position_out[i] = robot_position[i];
		}
	}	 
};