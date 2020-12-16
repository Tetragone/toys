#include "OthelloBoard.h"
#include <iostream>
#include <string>

using namespace std;

OthelloBoard::OthelloBoard()
{
}


OthelloBoard::~OthelloBoard()
{
}

void OthelloBoard::printUpBoard() {
	string space = "  ";

	for (int i = 0; i < 8; i++)
		cout << space << i << " ";

	cout << "\n";
}