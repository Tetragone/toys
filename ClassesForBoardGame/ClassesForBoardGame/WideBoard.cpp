#include "WideBoard.h"
#include <iostream>
#include <string>

using namespace std;

WideBoard::WideBoard()
{
}


WideBoard::~WideBoard()
{
}

void WideBoard::printUpBoard() {
	string space = "  ";

	for (int i = 0; i < size; i++)
		cout << space << i << " ";
}

void WideBoard::printMiddleLine(int location) {
	int printNum;

	if (!location) printNum = 2;
	else if (location == size) printNum = 8;
	else printNum = 5;

	cout << line[printNum];
	for (int i = 0; i < size - 1; i++) {
		cout << line[1] << line[printNum + 1];
	}
	cout << line[1] << line[printNum + 2];
}