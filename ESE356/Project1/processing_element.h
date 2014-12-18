#include "SystemC.h"
#include <iostream>
#include <fstream>
#include <string>
#include <exception>
using namespace std;


template <int inputs, int outputs, int L1, int L2, int operation>  class processing_element: public sc_module {
public:
	sc_in<bool> CLOCK;
	sc_in<int> in1, in2;
	sc_out<int> out1, out2;

	SC_HAS_PROCESS(processing_element);

	processing_element(sc_module_name name, string filename) : 
	sc_module(name), file(filename){

		for(int i = 0; i<L1+1; i++){
			internal1[i]=0;
		}
		for(int i = 0; i<L2+1; i++){
			internal2[i]=0;
		}

		SC_METHOD(myprocessing_element);
		sensitive<<CLOCK.pos();
	}

private:
	string file;
	int internal1[L1+1];
	int internal2[L2+1];

	void myprocessing_element(){

		try
		{
			if(CLOCK.posedge()){

				int tempout1;
				int tempout2;
				tempout1 = 0;
				tempout2 = 0;

				if ((inputs==1)&&(outputs==1)){
					//operation
					if (operation==3){
						int t = in1;
						tempout1 = t * 2;
					}


					//latency

					internal1[1] = tempout1;
					for(int i=L1-1;i>0;i--){
						internal1[i] = internal1[i-1];
					}


					//output
					out1 = internal1[L1-1];
				}


				if ((inputs==2)&&(outputs==1)){
					//operation
					if (operation==1){
						int t1 = in1;
						int t2 = in2;
						tempout1 = t1 + t2;
					}

					if (operation==4){
						int t1 = in1;
						int t2 = in2;
						tempout1 = t1 + t2;
					}

					if (operation==5){
						int t1 = in1;
						int t2 = in2;
						tempout1 = t1 + t2;
					}

					//latency
					internal1[1] = tempout1;
					for(int i=L1-1;i>0;i--){
						internal1[i] = internal1[i-1];
					}

					//output
					out1 = internal1[L1-1];
				}
				if ((inputs==1)&&(outputs==2)){
					//operation
					if (operation==6){
						int t1 = in1;
						int t2 = in2;

						tempout1 = t1 * 2;
						tempout2 = t2 * 3;
					}

					//latency
					internal1[1] = tempout1;
					for(int i=L1-1;i>0;i--){
						internal1[i] = internal1[i-1];
					}

					internal2[1] = tempout2;
					for(int i=L2-1;i>0;i--){
						internal2[i] = internal2[i-1];
					}

					//output
					out1 = internal1[L1-1];
					out2 = internal2[L2-1];
				}
				if ((inputs==2)&&(outputs==2)){
					//operation
					if (operation==2){
						int t1 = in1;
						int t2 = in2;
						tempout1 = t1 * t2;
						tempout2 = t1 - t2;
					}

					//latency
					internal1[1] = tempout1;
					for(int i=L1-1;i>0;i--){
						internal1[i] = internal1[i-1];
					}
					internal2[1] = tempout2;
					for(int i=L2-1;i>0;i--){
						internal2[i] = internal2[i-1];
					}

					//output
					out1 = internal1[L1-1];
					out2 = internal2[L2-1];
				}
				cout<<out1;
				cout<<out2;
			}
		}
		catch (exception& e)
		{
			cout << "Standard exception: " << e.what() << endl;
		}

	}

};

