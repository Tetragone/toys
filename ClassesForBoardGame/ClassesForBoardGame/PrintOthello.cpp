#include "PrintOthello.h"
#include <iostream>
#include <string>

using namespace std;

PrintOthello::PrintOthello()
{
	size = 8;
}


PrintOthello::~PrintOthello()
{
}

void PrintOthello::printMiddleLine(int location) {
	int printNum;
	
	if (!location) printNum = 2;
	else if (location == size) printNum = 8;
	else printNum = 5;

	cout << line[printNum];
	for (int i = 0; i < size - 1; i++) {
		cout << line[1] << line[printNum + 1];
	}
	cout << line[1] << line[printNum + 2] << "\n";
}

void PrintOthello::printBoardOneLine(int location) {
	for (int i = 0; i < size; i++) {
		cout << line[0];
		if (dat[location][i] == 0) cout << stone[0];
		else if (dat[location][i] == 1) cout << stone[1];
		else cout << "  ";
	}
	cout << line[0] << location << "\n";
}

void PrintOthello::printAll() {
	system("cls");
	printUpBoard();
	for (int i = 0; i < size; i++) {
		printMiddleLine(i);
		printBoardOneLine(i);
	}
	printMiddleLine(size);
}