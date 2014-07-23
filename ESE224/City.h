
/*---------------------------------------------------------*/
/* Class declaration for city template: */
// Parameters: int id, int ownerId, double value, 
//double charge, int xcoord, int ycoord, 
//String cityname, String owner, city* nextCity;
/* filename City.h */
#ifndef CITY_H
#define CITY_H
#include <iostream> 
using namespace std;


class City

{
	//Private attributes
private:
	int id;	//City Id
	int ownerId;	//City Owner's Id
	double value; //City's Property Value
	double charge;	//City's Property Value/5
	int xcoord;	//City's X position on Board
	int ycoord;	//City's Y position on Board
	string cityname;	//City's Name
	string owner; //City's Owner
	string tile; //City's Board Display
	City* nextCity; //Link City


public:
	City(); //Default constructor
	City(int idN, string ncityName, double nValue,
	int x, int y); //Parameterized constructor

	//Accessors
	int getId() const {return id;}
	int getOwnerId() const {return ownerId;}
	double getValue() const {return value;}
	double getCharge() const {return charge;}
	int getXcoord() const {return xcoord;}
	int getYcoord() const {return ycoord;}
	string getCityName() const {return cityname;}
	string getOwner() const {return owner;}
	string getTile() const {return tile;}
	City* getNextCity() const {return nextCity;}


	//Mutators
	void setId(int v);
	void setOwnerId(int v);
	void setValue(double v);
	void setCharge (double v);
	void setXcoord ( int v);
	void setYcoord (int v);
	void setCityName (string v);
	void setOwner (string v);
	void setTile (string v);
	void setNextCity (City*);

	//Additional Methods
	void print(ostream& out) const; //Print City's Attributes


};
#endif
/*---------------------------------------------------------*/
