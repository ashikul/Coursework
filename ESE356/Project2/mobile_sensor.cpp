#include "mobile_sensor.h"




void mobile_sensor::mymobile_sensor(){

	
	while(true){

	cout <<"mobile_sensor "<<" Time: "<<sc_time_stamp()<<endl;


	free_out = 1;
	if(valid_in.read() == 1){
		image = data[0].read();
		for(int i=1; i<6; i++){

			a[i] = data[i].read();
			b[i] = data[i+5].read();

		}
		//cout <<"~~~~Image "<<image<<" Time: "<<sc_time_stamp()<<endl;
		valid_out = 1;
		free_out = 1;
	}


	if(free_in.read()  == 1){
		free_out = 0;

		//cout << "Comparing at "<<sc_time_stamp()<<endl;

		for(int k=0; k<=4; k++)
		{
			//cout << "k "<<k<<"a-"<<a[k]<<"b-"<<b[k]<<"x-"<<x[counter]<<"y-"<<y[counter]<<endl;
			out.write(0);
			if( (x[counter] >= a[k] && x[counter] <= b[k]) && ( y[counter] >= a[k] && y[counter] <= b[k] ))
			{
				out.write(k+1  + image*10);

				//cout << "k "<<k<<"a-"<<a[k]<<"b-"<<b[k]<<"x-"<<x[counter]<<"y-"<<y[counter]<<" image-"<<image<<endl;
				//cout<<"out "<<out<<" time "<<sc_time_stamp()<<endl;

				break;
			}
		}
		counter++;

		wait(25, SC_NS);
		free_out = 1;

		}
	wait(30, SC_NS);
	}

};