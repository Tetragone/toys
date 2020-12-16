#include "OmokBoard.h"
#include <iostream>
#include <string>

using namespace std;

OmokBoard::OmokBoard()
{
}


OmokBoard::~OmokBoard()
{
}

void OmokBoard::printUpBoard() {
	char forPrint[16] = { '0','1','2','3','4','5','6','7','8','9','a','b','c','d','e', 'f' };
	string space = " ";

	for (int i = 0; i < 16; i++) 
		cout << space << forPrint[i];
	
	cout << "\n";
}