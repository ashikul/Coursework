//Player Class Header
// Parameters: String name, int playerId, double money  
/* filename Player.h */


#ifndef PLAYER_H
#define PLAYER_H
#include <iostream>
#include <string>
using namespace std;


class Player

{
private:
	string name; //Player's Name
	int id;	//Player's Id
	double money; //Player's Money
	int position; //Player's Position

public:
	Player(); //Default Constructor

	//Accessors
	string getName() const { return name;}
	int getId() const { return id;}
	double getMoney() const { return money;}
	int getPosition() const { return position;}

	//Mutators
	void setId(int v);
	void setMoney(double v);
	void setName (string v);
	void setPosition(int v);

	//Additional Methods
	void loseMoney(double m);	//Subtract Money
	void gainMoney(double m);	//Add Money
	void print(ostream& out) const;	//Print Player's Variables


};
#endif