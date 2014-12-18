#ifndef PACKETINC
#define PACKETINC

#include "systemc.h"
#pragma once

struct packet_type {

 int image;
 int A[5];
 int B[5];

 inline bool operator == (const packet_type& rhs) const
 {
	 return (rhs.image == image 
		 && rhs.A == A 
		 && rhs.B == B);
 }

 inline packet_type& operator = (const packet_type& rhs) {
	 image = rhs.image ;
	 for(int i=0; i<5; i++){ 
		 A[i] = rhs.A[i];
		 B[i] = rhs.B[i];
	 }
	 return *this;
 }

 inline friend void sc_trace(sc_trace_file *tf, const packet_type & v,
	 const std::string & NAME ) {
		 sc_trace(tf,v.image, NAME + ".image");
		 sc_trace(tf,v.A, NAME + ".A");
		 sc_trace(tf,v.B, NAME + ".B");
 }

 inline friend ostream& operator << ( ostream& os,  packet_type const & v ) {
	 os << "(" << v.image << "," << std::boolalpha << v.A << v.B << ")";
	 return os;
 }

};

#endif