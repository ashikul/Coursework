/*---------------------------------------------------*/
/* Class implementation for Player */
/* filename: player.cpp */
#include <iostream> 
#include <string> 
#include "Player.h"  
using namespace std;
//Constructors.
Player::Player() :
	id(0),money(0),name(""),position(0)  
{} 
//Accessors

//Mutators
void Player::setId (int v)
{
	id=v;
}
void Player::setMoney (double v)
{
	money=v;
}
void Player::setName  (string  v)
{
	name=v;
}
void Player::setPosition (int v)
{
	position=v;
} 
//Additional Methods

void Player::print(ostream& out) const
{
	out << "\n-------------------Player-----------------------------------" << endl;
	out << "\n\t\tPlayer Name: " << getName()  ;
	out << "\n\t\tPlayer ID: " << getId() ;
	out << "\n\t\tPlayer Money: " << getMoney() ;
	out << "\n------------------------------------------------------------" << endl;
}

void Player::loseMoney (double m)
{
	money=money-m;
}

void Player::gainMoney (double m)
{
	money=money+m;
}



/*--------------------------------------------------*/
