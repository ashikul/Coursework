#include "server.h"




void server::myserver(){


	
	while(true){

	cout <<"server "<<" Time: "<<sc_time_stamp()<<endl;
		

		//cout<<"in.read() "<<t<<" Time "<<sc_time_stamp()<<endl;

		valid_out = 0;
		data[0].write(image);
		//data[0] = image;

		//cout<<"Intialization2 "<<" data[0]"<<data[0]<<endl;
		for(int i=1; i<6; i++){ 
				//data[i] = a[i];
				//data[i+5] = b[i];
				data[i].write(a[i]);
				data[i+5].write(b[i]);
				
				//cout<<"Intialization2 "<<"i-"<<i<<"a "<<data[i]<<"b "<<data[i+5]<<endl;
		}

		if((first == false)){
			//cout <<"Count ----- "<<count<<endl;
			image++;
			data[0] = image;
			valid_out = 1;
			wait(WAIT_TIME*20, SC_NS);
			first = true;
			count++;
		}

		if(count % 100 == 0){

			//cout <<"Count -o- "<<count<<endl;
			image++;
			data[0] = image;
			valid_out = 1;
			wait(WAIT_TIME*40, SC_NS);
		}

		////if(free_in != 1){
		//	//network is not free
		//	int random = (rand()%(HI-LO))+LO;
		//	cout<<"DEBUG random "<<random<<endl;
		//	wait(random, SC_NS);
		//	//wait(20, SC_NS);
		////}

	//if(free_in.read() == 1){
	if(free_in.read() == 1){
		valid_out = 0;
		free_out = 0;
		int t = in.read();
		if ( t > 0){
			o[count] = t;
			//cout << "Object write "<<o[count]<<" count "<<count<<" Time "<<sc_time_stamp()<<endl;
			count++;
		}
 	
		wait(25, SC_NS);
		free_out = 1;

		}
		wait(25, SC_NS);
	}

	 
};