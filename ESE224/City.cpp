/*---------------------------------------------------*/
/* Class implementation for City */
/* filename: city.cpp */
#include <iostream> 
#include <string> 
#include "City.h"  
using namespace std;
//Constructors.
City::City() :
id(0),ownerId(0),value(0),charge(0),xcoord(0),ycoord(0),
cityname(""),owner(""),nextCity(nullptr),tile("*")
{}
City::City(int idN, string ncityName, double nValue,
int x, int y) : 
id(idN),ownerId(0),value(nValue),charge(value/5.0),xcoord(x),ycoord(y),
cityname(ncityName),owner(""),nextCity(nullptr),tile("*")
{}


//Mutators
void City::setId (int v)
{
	id=v;
}
void City::setOwnerId (int v)
{
	ownerId=v;
}
void City::setValue  (double  v)
{
	value =v;
}
void City::setCharge  (double  v)
{
	charge=v;
}
void City::setXcoord  (int  v)
{
	xcoord=v;
}
void City::setYcoord  (int  v)
{
	ycoord=v;
}
void City::setCityName  (string  v)
{
	cityname=v;
}
void City::setOwner  (string  v)
{
	owner =v;
}
void City::setTile  (string  v)
{
	tile =v;
}
void City::setNextCity(City* v)
{
	nextCity=v;
}
//Additional Methods

void City::print(ostream& out) const
{
	out << "\n-------------------City-----------------------------------" << endl;
	out << "\n\tCity Name: " << getCityName() << "City Id: " << getId() ;
	out << "\n\tCity Value: " << getValue() << "  City Fee: " << getCharge();
	out << "\n\tCity Position: < " << getXcoord() << " , " << getYcoord() << " >";
	out << "\n\tCity Owner Id: " << getOwnerId() << " Owner Name: " << getOwner();
	out << "\n----------------------------------------------------------" << endl;
}



/*--------------------------------------------------*/
