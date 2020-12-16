#include "PrintOmok.h"
#include <iostream>
#include <string>

using namespace std;

PrintOmok::PrintOmok()
{
	size = 16;
}


PrintOmok::~PrintOmok()
{
}

void PrintOmok::printBoardOneLine(int location) {
	int printNum;

	if (!location) printNum = 2;
	else if (location == size - 1) printNum = 8;
	else printNum = 5;

	for (int i = 0; i < size; i++) {
		if (dat[location][i] == 0) cout << stone[0];
		else if (dat[location][i] == 1) cout << stone[1];
		else if (!i) cout << line[printNum];
		else if (i == size - 1) cout << line[printNum + 2] << " ";
		else cout << line[printNum + 1];
	}

	location > 9 ? cout << (char)(location + 87) : cout << location;
	cout << "\n";
}

void PrintOmok::printAll() {
	system("cls");
	printUpBoard();
	for (int i = 0; i < size; i++) {
		printBoardOneLine(i);
	}
}