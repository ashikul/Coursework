#include "systemC.h"
#include "output.h"

int sc_main(int argc, char * argv [])
{

//input, output, signals
sc_signal <bool> sig_reset, sig_clear;
sc_signal <sc_uint <12>> sig_indata;
sc_signal <sc_uint <4>> sig_payload;
sc_signal <sc_uint <8>> sig_count, sig_error;

//sc_clock declaration
sc_clock sig_CLOCK ("CLOCK", 100, SC_NS);

//instantiation
output myoutput ("output");

//association
myoutput.CLOCK (sig_CLOCK);
myoutput.reset (sig_reset);
myoutput.clear (sig_clear);
myoutput.payload (sig_payload);
myoutput.count (sig_count);
myoutput.error (sig_error);
myoutput.indata (sig_indata);

//trace signals
sc_trace_file *fp;
fp = sc_create_vcd_trace_file ("wave");
sc_trace (fp, sig_CLOCK, "CLOCK");
sc_trace (fp, sig_reset, "reset");
sc_trace (fp, sig_clear, "clear"); 
sc_trace (fp, sig_indata, "InData"); 
sc_trace (fp, sig_payload, "payload");
sc_trace (fp, sig_count, "count");
sc_trace (fp, sig_error, "error");

//simulation start
sc_start (50, SC_NS);
sig_reset = 1;
sig_clear = 0;
sc_start (50, SC_NS);
sig_clear = 1;
sc_start (10, SC_NS);
sig_clear = 0;
sig_reset = 0;
sc_start (90, SC_NS);
sig_reset = 1;

sig_indata.write ("0x1F1");
sc_start (100, SC_NS);
sig_indata.write ("0x0E0");
sc_start (100, SC_NS);
sig_indata.write ("0x170");
sc_start (100, SC_NS);
sig_indata.write ("0x0E0");
sc_start (100, SC_NS);

sc_start (200, SC_NS);
sig_clear = 1;
sc_start (100, SC_NS);

sc_close_vcd_trace_file (fp);

system("pause");
return 0;
}