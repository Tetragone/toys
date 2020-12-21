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

void PrintOmok::printStone(int s) {
	if (s) cout << stone[1];
	else cout << stone[0];
}

void PrintOmok::printAll() {
	system("cls");
	printUpBoard();
	for (int i = 0; i < size; i++) {
		printBoardOneLine(i);
	}
}