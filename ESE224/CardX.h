/*---------------------------------------------------------*/
/*Card Header */
/* filename City.h */
 
#ifndef CARDX_H
#define CARDX_H
/* Card Class declaration */
/* filename: Card.h */
#include<iostream> //Required for ostream
using namespace std;
class Card {
public:
	//Constructors
	Card(); //Default
	Card(char aSuit,
		int aRank);//parameterized
	//Accessors
	int getRank() const;
	char getSuit() const;
	//Formatted Display Method
	//Example: if char is 'S' and rank is 11
	//output will be:
	//Jack of Spades
	void displayCard(ostream& outStream) const;
private:
	char suit;
	int rank;
};
#endif //end compiler directive ifndef
/*---------------------------------------------------------*/
