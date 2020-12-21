#include "NarrowBoard.h"
#include <iostream>
#include <string>

using namespace std;

NarrowBoard::NarrowBoard()
{
}


NarrowBoard::~NarrowBoard()
{
}

void NarrowBoard::printUpBoard() {
	char forPrint[16] = { '0','1','2','3','4','5','6','7','8','9','a','b','c','d','e', 'f' };
	string space = " ";

	for (int i = 0; i < 16; i++) 
		cout << space << forPrint[i];
	
	cout << "\n";
}

void NarrowBoard::printBoardOneLine(int location) {
	int printNum;

	if (!location) printNum = 2;
	else if (location == size - 1) printNum = 8;
	else printNum = 5;

	for (int i = 0; i < size; i++) {
		if (dat[location][i] != -1) printStone(dat[location][i]);
		else if (!i) cout << line[printNum];
		else if (i == size - 1) cout << line[printNum + 2];
		else cout << line[printNum + 1];
	}

	cout << " ";
	location > 9 ? cout << (char)(location + 87) : cout << location;
	cout << "\n";
}
// -1이 기본 값(틀) 그 외의 값을 돌