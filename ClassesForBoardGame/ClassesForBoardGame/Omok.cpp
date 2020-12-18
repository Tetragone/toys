#include "Omok.h"
#include <cstdlib>
#include <cstring>
#include <iostream>

using namespace std;

Omok::Omok(int s) : Board(s) {// constructor
}

bool Omok::check(int x, int y, int index) {
	int tempX = x;
	int tempY = y;
	length = 0;

	do {
		tempX += move[index][0];
		tempY += move[index][1];
		length++;

		if (tempX >= size || tempY >= size || tempX < 0 || tempY < 0) break;
	} while (dat[tempX][tempY] == turn);

	if (length == 5) return true;
	else return false;
} 

int Omok::putStone(char x, char y) {
	int tempX = transInputToInt(x);
	int tempY = transInputToInt(y);
	int result = -1;

	if (dat[tempX][tempY] == -1) dat[tempX][tempY] = turn;
	else return result;

	for (int i = 0; i < 8; i++) {
		if (check(tempX, tempY, i)) result = turn;
	}

	nextTurn();
	return result;
}