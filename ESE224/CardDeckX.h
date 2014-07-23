/*---------------------------------------------------------*/
#ifndef CARDDECKX_H
#define CARDDECKX_H
/* CardDeck class declaration */
/* filename: CardDeck.h */
#include "CardX.h" //Required for Card
#include <vector> //Required for vector */
using namespace std;
class CardDeck {
public:
	CardDeck();
	void shuffleDeck();
	Card draw();
private:
	vector<Card> theDeck;
	vector<Card> deltCards;
};
#endif
/*---------------------------------------------------------*/
