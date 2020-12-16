#include "Othello.h"
#include <cstdlib>
#include <cstring>
#include <iostream>
#include <stack>

using namespace std;

Othello::Othello()
{
	size = 8;
	dat = (int**)malloc(sizeof(int*) * size);
	dat[0] = (int*)malloc(sizeof(int) * size * size);
	for (int i = 1; i < size; i++) dat[i] = dat[i - 1] + size;
	memset(dat[0], -0x01, sizeof(int) * size * size);

	dat[3][3] = 0;
	dat[4][4] = 0;
	dat[3][4] = 1;
	dat[4][3] = 1;
}


Othello::~Othello()
{
	free(dat[0]);
	free(dat);
}

void Othello::totalStone() {
	whiteStone = 0;
	blackStone = 0;

	for (int i = 0; i < size; i++) {
		for (int j = 0; j < size; j++) {
			if (dat[i][j] == 1) whiteStone++;
			else if (dat[i][j] == 0) blackStone++;
		}
	}
}

int Othello::checkAll() {
	int counter = 0;

	for (int i = 0; i < size; i++) {
		for (int j = 0; j < size; j++) {
			for (int k = 0; k < 8; k++) {
				if (dat[i][j] == -1 && check(i, j, k)) {
					counter++;
					break;
				}
			}
		} 
	}

	return counter;
}

bool Othello::check(int x, int y, int index) {
	int length = -1;
	// 확인 조건 추가
	do {
		x += move[index][0];
		y += move[index][1];
		length++;
		if (x >= size || y >= size || x < 0 || y < 0) return false;
	} while (dat[x][y] == 1 - turn);

	if (length && dat[x][y] == turn) return true;
	else return false;
}

bool Othello::swapStone(int x, int y) {
	int tempX = x;
	int tempY = y;
	int checker = 0;

	for (int i = 0; i < 8; i++) {
		tempX = x;
		tempY = y;

		if (check(tempX, tempY, i)) {
			checker = 1;

			do {
				dat[tempX][tempY] = turn;

				tempX += move[i][0];
				tempY += move[i][1];
			} while (dat[tempX][tempY] == 1 - turn);

			dat[tempX][tempY] = turn;
		}
	}

	if (checker) return true;
	return false;
}

int Othello::putStone(char x, char y) {
	if (!checkAll()) {
		nextTurn();
		if (!checkAll()) {
			totalStone();
			if (whiteStone > blackStone) return 1;
			else if (whiteStone < blackStone) return 0;
			else return 2;
		}
	}

	int tempX = transInputToInt(x);
	int tempY = transInputToInt(y);
	int checker = 0;

	if (dat[tempX][tempY] == -1) {
		if (swapStone(tempX, tempY)) nextTurn();
	}

	return -1;
}