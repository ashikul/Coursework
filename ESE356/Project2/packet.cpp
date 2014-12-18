#include "packet.h"
#include "systemc.h"
#include <string>

void sc_trace(sc_trace_file *tf, const packet_type& v,
 const std::string& NAME) {
 sc_trace(tf,v.image, NAME + ".image");
 sc_trace(tf,v.A, NAME + ".A");
 sc_trace(tf,v.B, NAME + ".B");
 }