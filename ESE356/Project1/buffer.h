//input
//
//start_write - if high, read
//output
//
//start_read
//multiplexers
//clock
//sync start_write with start_read

//2 data inputs, only 1 is active
//2 data output, only 1 is active
//start_wrte -> M
//start_read -> M



#include "SystemC.h"


template <int M, unsigned D> class buffer: public SC_MODULE{//Memory size and Direction
	
	public:
		sc_in<bool> CLOCK, start_write, start_read;
		sc_in<sc_int<16> > in1, in2;
		sc_out<sc_int<16> > out1, out2;
	

		void myprocessing_element();

		SC_CTOR(buffer){
			sc_method(buffer)
				senstive<<CLOCK.pos()<<start_write<<start_read;
				//intialization
				//pointer intialization
				current_write_count = 0;
				current_read_count = 0;
		}
	private:
		<sc_int<16> > memory[M];
		<sc_int<16> > current_write_count;
		<sc_int<16> > current_read_count; 
	};



//template <class T, unsigned N> class buffer: public sc_module {
//public:
//	sc_in<bool> clock;
//	sc_in<T> inl
//	sc_out<T> out;
//	SC_HAS_PROCESS(buffer);
//
//	buffer(sc_module_name name,
//		const T coeff):
//		sc_module(name), coeff(coeff)
//}


/*
generic AND gate
#include "systemc.h"

template <int size>
	SC_MODULE(generic_and){
		sc_in<sc_unit<size> > a;
		sc_out<bool> z;
		void prc_generic_and();
		SC_CTOR(generic_and){
			sc_method(prc_generic_and)
				senstive<<a;
		}
	}

template<int size>
void generic_and::prc_generic_and(){
	sc_bv<size> bv _temp;
	bv_temp a.read();
	z = bv_temp.and_reduce();

sc_module(generic_instantiate){
	sc_in<sc_uint<6> >tsq;
	sc_out<bool> rsq;
	void prc_xor();
	void prc_split();
	generic_and<2> *and2;
	generic_and<4> *and4;







*/




//SC_MODULE(output){
//	//ports
//	sc_in<bool> CLOCK;
//	sc_in<bool> reset, clear;
//	sc_in<sc_uint<12>> indata;
//	sc_out<sc_uint<4>> payload;
//	sc_out<sc_uint<8>> count, error;
//	
//	//processes
//	void myoutput();
//	SC_CTOR(output){
//		
//		SC_METHOD(myoutput);
//		sensitive<<CLOCK.pos()<<reset<<clear;
//	}
//};