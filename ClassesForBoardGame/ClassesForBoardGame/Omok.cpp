#include "Omok.h"
#include <cstdlib>
#include <cstring>
#include <iostream>

using namespace std;

Omok::Omok(int s) : Board(s) {// constructor
}


int Omok::putStone(char x, char y) {
	int tempX = transInputToInt(x);
	int tempY = transInputToInt(y);
	int result = -1;

	if (dat[tempX][tempY] == -1) dat[tempX][tempY] = turn;
	else return result;

	for (int i = 0; i < 8; i++) {
		check(tempX, tempY, i);
		if (length == 5) result = turn;
	}

	nextTurn();
	return result;
}