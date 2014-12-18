#include "systemc.h"
#include <string>
#include <iostream>
#include <fstream>
#include "buffer.h"
#include "processing_element.h"
#include "interconnect.h"
#include "controller.h"
using namespace std;

int sc_main(int argc, char *argv [])
{
	//input, output, signals
	sc_signal <int> sig[110], sig_D1, sig_D2;
	sc_signal <bool> sig2[20];

	//sc_clock declaration
	sc_clock sig_clock ("clock", 50, SC_NS);

	//instantiation and association

	processing_element<2,1,2,9,1> pe1("pe1", "pe1.txt");
	pe1.CLOCK(sig_clock);
	pe1.in1(sig_D1);
	pe1.in2(sig[1]);
	pe1.out1(sig[2]);
	pe1.out2(sig[40]);//
	processing_element<2,2,4,5,2> pe2("pe2", "pe2.txt");
	pe2.CLOCK(sig_clock);
	pe2.in1(sig[23]);
	pe2.in2(sig[24]);
	pe2.out1(sig[25]);
	pe2.out2(sig[26]);
	processing_element<1,1,3,9,3 > pe3("pe3", "pe3.txt");
	pe3.CLOCK(sig_clock);
	pe3.in1(sig[3]);
	pe3.out1(sig[4]);
	pe3.in2(sig[42]);//
	pe3.out2(sig[43]);//
	processing_element<2,1,7,9,4 > pe4("pe4", "pe4.txt");
	pe4.CLOCK(sig_clock);
	pe4.in1(sig[27]);
	pe4.in2(sig[28]);
	pe4.out1(sig[29]);
	pe4.out2(sig[41]);//
	processing_element<2,1,5,9,5 > pe5("pe5", "pe5.txt");
	pe5.CLOCK(sig_clock);
	pe5.in1(sig_D2);
	pe5.in2(sig[5]);
	pe5.out1(sig[6]);
	pe5.out2(sig[44]); //
	processing_element<1,2,6,2,6 > pe6("pe6", "pe6.txt");
	pe6.CLOCK(sig_clock);
	pe6.in1(sig[30]);
	pe6.in2(sig[45]); //
	pe6.out1(sig[31]);
	pe6.out2(sig[32]);

	buffer<10, 1> buffer1("buffer1");
	buffer1.CLOCK(sig_clock);
	buffer1.in1(sig[7]);
	buffer1.in2(sig[94]);//
	buffer1.out1(sig[95]);//
	buffer1.out2(sig[13]);
	buffer1.start_read(sig2[1]);
	buffer1.start_write(sig2[2]);

	buffer<10, 2> buffer2("buffer2");
	buffer2.CLOCK(sig_clock);
	buffer2.in1(sig[96]);
	buffer2.in2(sig[14]);
	buffer2.out1(sig[8]);
	buffer2.out2(sig[97]);
	buffer2.start_read(sig2[3]);
	buffer2.start_write(sig2[4]);

	buffer<10, 2> buffer3("buffer3");
	buffer3.CLOCK(sig_clock);
	buffer3.in1(sig[98]);//
	buffer3.in2(sig[15]);
	buffer3.out1(sig[9]);
	buffer3.out2(sig[99]);//
	buffer3.start_read(sig2[5]);
	buffer3.start_write(sig2[6]);

	buffer<10, 1> buffer4("buffer4");
	buffer4.CLOCK(sig_clock);
	buffer4.in1(sig[10]);
	buffer4.out2(sig[16]);
	buffer4.in2(sig[100]);//
	buffer4.out1(sig[101]);//
	buffer4.start_read(sig2[7]);
	buffer4.start_write(sig2[8]);

	buffer<10, 3> buffer5("buffer5");
	buffer5.CLOCK(sig_clock);
	buffer5.in2(sig[21]);
	buffer5.out2(sig[17]);
	buffer5.in1(sig[102]);//
	buffer5.out1(sig[103]);//
	buffer5.start_read(sig2[9]);
	buffer5.start_write(sig2[10]);

	buffer<10, 3> buffer6("buffer6");
	buffer6.CLOCK(sig_clock);
	buffer6.in2(sig[18]);
	buffer6.out2(sig[20]);
	buffer6.in1(sig[104]);//
	buffer6.out1(sig[105]);//
	buffer6.start_read(sig2[11]);
	buffer6.start_write(sig2[12]);

	buffer<10, 1> buffer7("buffer7");
	buffer7.CLOCK(sig_clock);
	buffer7.in1(sig[11]);
	buffer7.out2(sig[19]);
	buffer7.in2(sig[106]);//
	buffer7.out1(sig[107]);//
	buffer7.start_read(sig2[13]);
	buffer7.start_write(sig2[14]);

	buffer<10, 2> buffer8("buffer8");
	buffer8.CLOCK(sig_clock);
	buffer8.in2(sig[22]);
	buffer8.out1(sig[12]);
	buffer8.in1(sig[108]);//
	buffer8.out2(sig[109]);//
	buffer8.start_read(sig2[15]);
	buffer8.start_write(sig2[16]);


	interconnect<1> interconnect1("interconnect1", "flag1.txt");
	interconnect1.CLOCK(sig_clock);


	interconnect1.in[0](sig[66]); //
	interconnect1.in[1](sig[2]);
	interconnect1.in[2](sig[67]); //
	interconnect1.in[3](sig[68]); //
	interconnect1.in[4](sig[69]); //
	interconnect1.in[5](sig[4]);
	interconnect1.in[6](sig[70]); //
	interconnect1.in[7](sig[6]);
	interconnect1.in[8](sig[71]); //
	interconnect1.in[9](sig[72]); //
	interconnect1.in[10](sig[73]); //
	interconnect1.in[11](sig[8]);
	interconnect1.in[12](sig[9]);
	interconnect1.in[13](sig[74]); //
	interconnect1.in[14](sig[75]); //
	interconnect1.in[15](sig[76]); //
	interconnect1.in[16](sig[77]); //
	interconnect1.in[17](sig[12]);
	interconnect1.in[18](sig[78]); //
	interconnect1.in[19](sig[79]); //



	interconnect1.out[0](sig[1]);
	interconnect1.out[1](sig[80]); //
	interconnect1.out[2](sig[81]); //
	interconnect1.out[3](sig[3]);
	interconnect1.out[4](sig[82]); //
	interconnect1.out[5](sig[83]); //
	interconnect1.out[6](sig[5]);
	interconnect1.out[7](sig[84]); //
	interconnect1.out[8](sig[85]); //
	interconnect1.out[9](sig[86]); //
	interconnect1.out[10](sig[7]);
	interconnect1.out[11](sig[87]); //
	interconnect1.out[12](sig[88]); //
	interconnect1.out[13](sig[89]); //
	interconnect1.out[14](sig[10]);
	interconnect1.out[15](sig[90]); //
	interconnect1.out[16](sig[11]);
	interconnect1.out[17](sig[91]); //
	interconnect1.out[18](sig[92]); //
	interconnect1.out[19](sig[93]); //

	interconnect<2> interconnect2("interconnect2", "flag2.txt");
	interconnect2.CLOCK(sig_clock);


	interconnect2.in[0](sig[13]);
	interconnect2.in[1](sig[46]); //
	interconnect2.in[2](sig[47]); //
	interconnect2.in[3](sig[16]);
	interconnect2.in[4](sig[17]);
	interconnect2.in[5](sig[48]); //
	interconnect2.in[6](sig[19]);
	interconnect2.in[7](sig[20]);
	interconnect2.in[8](sig[49]); //
	interconnect2.in[9](sig[50]); //
	interconnect2.in[10](sig[65]); //
	interconnect2.in[11](sig[51]); //
	interconnect2.in[12](sig[25]);
	interconnect2.in[13](sig[26]);
	interconnect2.in[14](sig[51]); //
	interconnect2.in[15](sig[52]); //
	interconnect2.in[16](sig[29]);
	interconnect2.in[17](sig[53]); //
	interconnect2.in[18](sig[31]);
	interconnect2.in[19](sig[32]);



	interconnect2.out[0](sig[54]); //
	interconnect2.out[1](sig[14]);
	interconnect2.out[2](sig[15]);
	interconnect2.out[3](sig[55]); //
	interconnect2.out[4](sig[56]); //
	interconnect2.out[5](sig[18]);
	interconnect2.out[6](sig[57]); //
	interconnect2.out[7](sig[58]); //
	interconnect2.out[8](sig[21]);
	interconnect2.out[9](sig[22]);
	interconnect2.out[10](sig[23]); //
	interconnect2.out[11](sig[24]);
	interconnect2.out[12](sig[60]); //
	interconnect2.out[13](sig[61]); //
	interconnect2.out[14](sig[27]);
	interconnect2.out[15](sig[28]);
	interconnect2.out[16](sig[62]); //
	interconnect2.out[17](sig[30]);
	interconnect2.out[18](sig[63]); //
	interconnect2.out[19](sig[64]); //


	controller<8> controller1("controller1", "control.txt");
	controller1.CLOCK(sig_clock);
	//unused
	controller1.read[0](sig2[17]);
	controller1.write[0](sig2[18]);
	//
	controller1.read[1](sig2[1]);
	controller1.write[1](sig2[2]);
	controller1.read[2](sig2[3]);
	controller1.write[2](sig2[4]);
	controller1.read[3](sig2[5]);
	controller1.write[3](sig2[6]);
	controller1.read[4](sig2[7]);
	controller1.write[4](sig2[8]);
	controller1.read[5](sig2[9]);
	controller1.write[5](sig2[10]);
	controller1.read[6](sig2[11]);
	controller1.write[6](sig2[12]);
	controller1.read[7](sig2[13]);
	controller1.write[7](sig2[14]);
	controller1.read[8](sig2[15]);
	controller1.write[8](sig2[16]);

	//trace signals
	sc_trace_file *fp = sc_create_vcd_trace_file ("waveP1");
	sc_trace (fp, sig_clock, "CLOCK");
	sc_trace (fp, sig[2], "pe1_output");
	sc_trace (fp, sig[25], "pe2_output");
	sc_trace (fp, sig[26], "pe2_output");
	sc_trace (fp, sig[4], "pe3_output");
	sc_trace (fp, sig[29], "pe4_output");
	sc_trace (fp, sig[6], "pe5_output");
	sc_trace (fp, sig[31], "pe6_output");
	sc_trace (fp, sig[32], "pe6_output");
	sc_trace (fp, sig_D1, "Driver_1");
	sc_trace (fp, sig_D2, "Driver_2");

	//simulation start
	sig_D1 = 10;
	sig_D2 = 5;
	sc_start (1000, SC_NS);
	sig_D1 = 2;
	sig_D2 = 20;
	sc_start (1000, SC_NS);
	sig_D1 = 0;
	sig_D2 = 0;
	sc_start (1000, SC_NS);
	sig_D1 = 0;
	sig_D2 = 1;
	sc_start (1000, SC_NS);
	sig_D1 = 1;
	sig_D2 = 1;
	sc_start (1000, SC_NS);

	sc_close_vcd_trace_file (fp);

	system("pause");
	return 0;

}
