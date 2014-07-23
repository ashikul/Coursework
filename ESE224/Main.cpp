/*---------------------------------------------------------*/
/*ESE 224 Final Project */
/*By Ashikul Alam 108221262*/
/*Simulates a game of Monopoly in C++ Text*/
/* Main class implementation                               */
/* filename: Main.cpp                                      */

#include "City.h"
#include "Player.h"
#include "CardX.h"
#include "CardDeckX.h"

#include<iostream> //Required for cout
#include<fstream> //Required for ifstream
#include<string>
using namespace std;

double cardGame (); //Prototype for Card Mini-Game

int main()
{
#pragma region "VARIABLES"



	string header;
	int id;
	string cityName; 
	string name; 
	double value; 
	double money;
	int x;
	int y;
	int gameTurns(0);
	int roll;

	const int NUMBER_OF_CITIES = 16;
	const int NUMBER_OF_PLAYERS = 4;
	City arrayCity[NUMBER_OF_CITIES+1];
	Player arrayPlayer[NUMBER_OF_PLAYERS+1];
#pragma endregion  

#pragma region "INPUT CITIES"
	ifstream fin;
	fin.open("C:\\city.txt");
	if(fin.fail())
	{
		cerr <<"Could not open file city.txt" <<endl;
		exit(1);
	}
	getline(fin,header);

	for (int i = 1; i < NUMBER_OF_CITIES+1; ++i)
	{

		fin >> id >> cityName >> value >> x >> y;

		arrayCity[i] = City();
		arrayCity[i].setId(id);
		arrayCity[i].setCityName(cityName);
		arrayCity[i].setValue(value);
		arrayCity[i].setCharge(value/5.0);
		arrayCity[i].setXcoord(x);
		arrayCity[i].setYcoord(y);


	}

#pragma endregion

#pragma region "INPUT PLAYERS"
	ifstream fin2;
	fin2.open("C:\\player.txt");
	if(fin2.fail())
	{
		cerr <<"Could not open file player.txt" <<endl;
		exit(1);
	}
	getline(fin2,header);

	for (int i = 1; i < NUMBER_OF_PLAYERS+1; ++i)
	{

		fin2 >> id >> name >> money ;

		arrayPlayer[i] = Player();
		arrayPlayer[i].setId(id);
		arrayPlayer[i].setName(name);
		arrayPlayer[i].setMoney(money);
		arrayPlayer[i].setPosition(1); 


	}


#pragma endregion 

#pragma region "MAIN WHILE LOOP"

		//Game Start
	cout << "Welcome to Monopoly!" << endl;
	//Ask for Game Turns
	cout <<  "Please enter game turns :" ;
	cin >> gameTurns ;

	do{
		//For each Player
		for (int i = 1; i < NUMBER_OF_PLAYERS+1; i++){

#pragma region "DISPLAY BOARD"
			cout << "\n" <<endl;
			cout << arrayCity[1].getTile() << arrayCity[2].getTile() << arrayCity[3].getTile() <<arrayCity[4].getTile() <<arrayCity[5].getTile() <<endl;
			cout << arrayCity[16].getTile() << "   " << arrayCity[6].getTile() << endl;
			cout << arrayCity[15].getTile() << "   " << arrayCity[7].getTile() << endl;
			cout << arrayCity[14].getTile() << "   " << arrayCity[8].getTile() << endl;
			cout << arrayCity[13].getTile() << arrayCity[12].getTile() << arrayCity[11].getTile() <<arrayCity[10].getTile() <<arrayCity[9].getTile() <<endl;
			cout << "\n" <<endl;	
#pragma endregion  
			//Display Player's Name
			cout << "###############################" << endl;
			cout << "########" << arrayPlayer[i].getName() << "'s turn ########" << endl;
			cout << "###############################" << endl;
			//Roll Die
			roll = rand() % 6 + 1; 
			cout << "\n" << endl;
			cout << "\t\tDie result is " << roll << endl;

			//Modify City's old Tile
			int oldPosition = arrayPlayer[i].getPosition();
			arrayCity[oldPosition].setTile("*");

			//Move the Player
			arrayPlayer[i].setPosition((arrayPlayer[i].getPosition()+roll)%17);
			int newPosition = arrayPlayer[i].getPosition();
			arrayCity[newPosition].setTile(std::to_string(arrayPlayer[i].getId()));

			//Print the Newly Landed City
			arrayCity[newPosition].print(cout);

			//Check If Tile is Buyable
			if (arrayCity[newPosition].getOwnerId() == 0){

				//Check if Player has Money to buy
				if( arrayCity[newPosition].getValue() > arrayPlayer[i].getMoney())

				{ 

					cout <<  "Not enough purchasing $!" << endl;

				}

				//Check if its the user
				if ( arrayPlayer[i].getId()==1){




					cout <<  "Purchase this city (y/n)? :" ;
					char answer;
					cin >> answer ;

					if (answer == 'y'){

						double cost = arrayCity[newPosition].getValue();
						arrayCity[newPosition].setOwner(arrayPlayer[1].getName()); //Set City's Owner Name
						arrayCity[newPosition].setOwnerId(arrayPlayer[1].getId()); //Set City's Owner Id
						arrayPlayer[1].loseMoney(cost); //Charge City Value Cost
						cout << "\n" << endl;
						cout << arrayPlayer[i].getName() << " has purchased " <<
							arrayCity[newPosition].getCityName() << " for $" << arrayCity[newPosition].getValue() << endl;


					} else {



					}


					//Else for AI
				} else  {

					//50% Roll Check
					int buyChance = rand() % 2 + 1;


					if (buyChance == 1){

						double cost = arrayCity[newPosition].getValue();
						arrayCity[newPosition].setOwner(arrayPlayer[i].getName()); //Set City's Owner Name
						arrayCity[newPosition].setOwnerId(arrayPlayer[i].getId()); //Set City's Owner Id
						arrayPlayer[i].loseMoney(cost); //Purchase Cost
						cout << "\n" << endl;
						cout << arrayPlayer[i].getName() << " has purchased " <<
							arrayCity[newPosition].getCityName() << " for $" << arrayCity[newPosition].getValue() << endl;

					} else {



					}

				}

			} else {

				//Charge for Landing on an Owned Tile
				if ( arrayCity[newPosition].getOwnerId() != arrayPlayer[i].getId() ){
					double fee = arrayCity[newPosition].getCharge();
					int cityOwner = arrayCity[newPosition].getOwnerId();
					arrayPlayer[i].loseMoney(fee);
					arrayPlayer[cityOwner].gainMoney(fee); //Give Money to Owner
					cout << "\n" <<endl;
					cout << arrayPlayer[i].getName() << " paid a fee of $ " << fee << endl;
					cout << arrayPlayer[cityOwner].getName() << " gained $" << fee << endl;
				}

			}



#pragma region "Check if Good Tile"
			if ((newPosition == 2)|
				(newPosition == 6)|
				(newPosition == 10)|
				(newPosition == 14)){

					double gain = cardGame(); //Method for Card Mini-Game
					arrayPlayer[i].gainMoney(gain); 
					cout << arrayPlayer[i].getName() << " gained $" << gain << endl;

			}
#pragma endregion

#pragma region "Check if Bad Tile"

			if ((newPosition == 3)|
				(newPosition == 7)|
				(newPosition == 11)|
				(newPosition == 14)){

					arrayPlayer[i].loseMoney(500);
					cout << "Landed on a bad tile! " << arrayPlayer[i].getName() << " lost $500!" << endl;
			}

			arrayPlayer[i].print(cout);

#pragma endregion





		}



		gameTurns--;
	} while (gameTurns != 0);



#pragma endregion 

#pragma region "Game End, Declare Winner"
	cout << "\n"<<endl;
	cout << "Monopoly finished!" << endl;
	Player tempPlayer = arrayPlayer[1];

	//Get the Highest Money
	for (int i = 2; i < NUMBER_OF_PLAYERS+1; ++i){

		if ( arrayPlayer[i].getMoney() > tempPlayer.getMoney()){
			tempPlayer = arrayPlayer[i];
		}

	}
	cout << "\n"<<endl;

	//Display all the Player's Money
	for (int i = 1; i < NUMBER_OF_PLAYERS+1; ++i){

		cout <<  arrayPlayer[i].getName() << " has $"  << arrayPlayer[i].getMoney() << endl;

	}


	cout << "\n"<<endl;
	cout << "The winner is " << tempPlayer.getName() << "!!!!!!!!!!" << endl;
#pragma endregion

	system("pause");
	return 0;
}

#pragma region "Card Mini-Game Method"

double cardGame (){


	CardDeck theDeck;	//New CardDeck Object
	theDeck = CardDeck(); //Constructor

	Card card1, card2; //2 New Card Objects
	card1 = Card();	//Constructor
	card2 = Card(); //Constructor

	theDeck.shuffleDeck(); //Shuffle Deck
	theDeck.shuffleDeck(); //Again Incase

	card1 = theDeck.draw();	//Draw a card from the Deck
	card2 = theDeck.draw();	//Draw a card from the Deck
	bool isCard1Black(false); //Bool to check, assumed red
	bool isCard2Black(false); //Bool to check, assumed red

	//Check if card1 is black
	if( (card1.getSuit() == 'D' || card1.getSuit() == 'C')){
		isCard1Black = true;
	}
	//Check if card2 is black
	if( (card2.getSuit() == 'D' || card2.getSuit() == 'C')){
		isCard2Black = true;
	}

	cout << "\nCard Mini-Game! Drawing two cards...";
	cout << "\n";
	card1.displayCard(cout);
	cout << "\n";
	card2.displayCard(cout);
	cout << "\n";

	//If card1 and card 2 are opposite colors...
	if (isCard1Black != isCard2Black){

		return 100*(card1.getRank()+card1.getRank());
	}
	return 0;

}
#pragma endregion