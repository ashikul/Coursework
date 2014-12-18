#include "systemC.h"
#include "environment.h"
#include "server.h"
#include "robot.h"
#include "environment.h"



//#include <cstdlib>
//#include <ctime>
//#include <iostream>
//#include <fstream>
//#include <string>
//#include "time.h"
//#include <cstdlib>
//using namespace std;





int sc_main(int argc, char* argv[]){

		//two clocks

		sc_signal<int> sc_robot_position[3], sc_robot_move_position[3];
		sc_signal<bool> sc_robot_stop[3], sc_collision[3];

		sc_clock sig_CLOCK1 ("CLOCK1", 150, SC_NS);
		sc_clock sig_CLOCK2 ("CLOCK2", 50, SC_NS);

		server server1("server");
		server1.CLOCK(sig_CLOCK1);
		for(int i=0; i<3; i++){ 

			server1.robot_position[i](sc_robot_position[i]);
			server1.robot_move_position[i](sc_robot_move_position[i]);
			server1.robot_stop[i](sc_robot_stop[i]);
			server1.collision[i](sc_collision[i]);
		}

		robot robot1("robot");
		robot1.CLOCK(sig_CLOCK1);
		for(int i=0; i<3; i++){ 

			robot1.robot_position_in[i](sc_robot_position[i]);
			robot1.robot_position_out[i](sc_robot_move_position[i]);
		}

		
		environment environment1("environment");
		environment1.CLOCK(sig_CLOCK2);
		for(int i=0; i<3; i++){ 

			environment1.robot_position[i](sc_robot_position[i]);
			environment1.collision[i](sc_collision[i]);
		}

		sc_trace_file *waveform = sc_create_vcd_trace_file("waveformProject3");
		sc_trace(waveform, sig_CLOCK1, "Clock1");
		sc_trace(waveform, sig_CLOCK2, "Clock2");

		for(int i=0; i<3; i++){

			sc_trace(waveform, sc_robot_position[i], "robot");
			sc_trace(waveform, sc_robot_move_position[i], "robot_move");
			sc_trace(waveform, sc_collision[i], "collision");
			sc_trace(waveform, sc_robot_stop[i], "robot_stop");
		}

		sc_start(1000, SC_NS);
		sc_close_vcd_trace_file(waveform);

		system("pause");
		return 0;
	} 
