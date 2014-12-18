#include "systemC.h"
#include "server.h"
#include "mobile_sensor.h"
#include "packet.h"
//#include <cstdlib>
//#include <ctime>
//#include <iostream>
//#include <fstream>
//#include <string>
//#include "time.h"
//#include <cstdlib>
//using namespace std;


int sc_main(int argc, char* argv[]){
		srand (static_cast <unsigned> (time(0)));

		sc_signal<int> sc_data[12];
		sc_signal<bool> sc_free1, sc_free2;
		sc_signal<bool> sc_valid1, sc_valid2;
		sc_signal<int> sig_out;

		sc_clock sig_CLOCK ("CLOCK", 50, SC_NS);

		server server1("server");
		server1.free_in(sc_free1);
		server1.valid_in(sc_valid1);
		server1.free_out(sc_free2);
		server1.valid_out(sc_valid2);
		server1.in(sig_out);
		server1.CLOCK(sig_CLOCK);

		for(int i=0; i<12; i++){ 
			server1.data[i](sc_data[i]);
		}

		mobile_sensor mobile_sensor1("mobile_sensor");
		mobile_sensor1.free_in(sc_free2);
		mobile_sensor1.valid_in(sc_valid2);
		mobile_sensor1.free_out(sc_free1);
		mobile_sensor1.valid_out(sc_valid1);
		mobile_sensor1.out(sig_out);
		mobile_sensor1.CLOCK(sig_CLOCK);

		for(int i=0; i<12; i++){ 
			mobile_sensor1.data[i](sc_data[i]);
		}

		sc_trace_file *waveform = sc_create_vcd_trace_file("waveformProject2Phase2");
		//sc_trace(waveform, sc_data[0], "data image");
		sc_trace(waveform, sc_free1, "free1");
		sc_trace(waveform, sc_free2, "free2");
		sc_trace(waveform, sc_valid1, "valid1");
		sc_trace(waveform, sc_valid2, "valid2");
		//sc_trace(waveform, sig_out, "object data");
		sc_trace(waveform, sig_CLOCK, "Clock");

		sc_start(50000, SC_NS);
		sc_close_vcd_trace_file(waveform);

		system("pause");
		return 0;
	} 
