#include "Omok.h"
#include <cstdlib>
#include <cstring>
#include <iostream>

using namespace std;

Omok::Omok()
{
	size = 16;
	dat = (int**)malloc(sizeof(int*) * size);
	dat[0] = (int*)malloc(sizeof(int) * size * size);
	for (int i = 1; i < size; i++) dat[i] = dat[i - 1] + size;
	memset(dat[0], -0x01, sizeof(int) * size * size);
}

Omok::~Omok()
{
	free(dat[0]);
	free(dat);
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