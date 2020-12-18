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

void PrintOthello::printBoardOneLine(int location) {
	for (int i = 0; i < size; i++) {
		cout << line[0];
		if (dat[location][i] == 0) cout << stone[0];
		else if (dat[location][i] == 1) cout << stone[1];
		else cout << "  ";
	}
	cout << line[0] << location;
}

void PrintOthello::printAll() {
	system("cls");
	printUpBoard();
	cout << "\n";
	for (int i = 0; i < size; i++) {
		printMiddleLine(i);
		cout << "\n";
		printBoardOneLine(i);
		cout << "\n";
	}
	printMiddleLine(size);
	cout << "\n";
}