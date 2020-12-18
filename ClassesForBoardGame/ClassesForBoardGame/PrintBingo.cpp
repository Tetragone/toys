#include "PrintBingo.h"
#include <iostream>
#include <string>

using namespace std;

PrintBingo::PrintBingo()
{
	size = 5;
}


PrintBingo::~PrintBingo()
{
}

void PrintBingo::printAll() {
	system("cls");
	printUpBoard();
	cout << "          ";
	printUpBoard();
	cout << "\n";

	for (int i = 0; i < size; i++) {
		printMiddleLine(i);
		cout << "        ";
		printMiddleLine(i);
		cout << "\n";
		printBoardOneLine(i, dat);
		cout << "       ";
		printBoardOneLine(i, dat2);
		cout << "\n";
	}

	printMiddleLine(size);
	cout << "        ";
	printMiddleLine(size);
	cout << "\n";
}

void PrintBingo::printBoardOneLine(int location, int **setUp) {
	for (int i = 0; i < size; i++) {
		cout << line[0];
		if (setUp[location][i] == 0) cout << stone[0];
		else if (setUp[location][i] >= 10) cout << setUp[location][i];
		else cout << setUp[location][i] << " ";
	}
	cout << line[0] << location;
}