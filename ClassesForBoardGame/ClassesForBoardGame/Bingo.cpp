#include "Bingo.h"
#include <cstdlib>
#include <cstring>
#include <iostream>
#include <ctime>

using namespace std;

Bingo::Bingo(int s) : Board(s)
{
	size = s;
	dat2 = (int**)malloc(sizeof(int*) * size);
	dat2[0] = (int*)malloc(sizeof(int) * size * size);
	for (int i = 1; i < size; i++) dat2[i] = dat2[i - 1] + size;
	memset(dat2[0], 0, sizeof(int) * size * size);
	memset(dat[0], 0, sizeof(int) * size * size);
	srand((unsigned int)time(NULL));
	this->init(dat);
	this->init(dat2);
	amountBingo[0] = 0;
	amountBingo[1] = 0;
}


Bingo::~Bingo()
{
	free(dat[0]);
	free(dat);
	free(dat2[0]);
	free(dat2);
}

void Bingo::init(int** setup) {
	int divid = size * size;
	int* putValue = (int*)malloc(size * size * sizeof(int));

	for (int i = 0; i < size * size; i++) putValue[i] = i + 1;

	for (int i = 0; i < size; i++) {
		for (int j = 0; j < size; j++) {
			int r = rand() % divid;

			setup[i][j] = putValue[r];

			int temp = putValue[r];
			putValue[r] = putValue[divid - 1];
			putValue[divid - 1] = temp;

			divid--;
		}
	}
	
	free(putValue);
}

int Bingo::putStone(char x, char y) {
	int counter = 0;
	int result = -1;

	for (int i = 0; i < size; i++) {
		for (int j = 0; j < size; j++) {
			if (dat[i][j] == x) dat[i][j] = 0;
			if (dat2[i][j] == x) dat2[i][j] = 0;
		}
	}
	checkAll();

	if (amountBingo[0] >= 5) result += 1;
	if (amountBingo[1] >= 5) result += 2;

	nextTurn();

	return result;
}

bool Bingo::check(int x, int y, int index, int** search) {
	int tempX = x;
	int tempY = y;

	while (search[tempX][tempY] == 0) {
		tempX += move[index][0];
		tempY += move[index][1];

		if (tempX >= size || tempY >= size || tempX < 0 || tempY < 0) return true;
	}
	return false;
}

void Bingo::checkAll() {
	amountBingo[0] = 0;
	amountBingo[1] = 0;

	for (int i = 0; i < size; i++) {
		if (check(i, 0, 7, dat)) amountBingo[0]++;
		if (check(i, 0, 7, dat2)) amountBingo[1]++;
		if (check(0, i, 5, dat)) amountBingo[0]++;
		if (check(0, i, 5, dat2)) amountBingo[1]++;
	}
	if (check(0, 0, 6, dat)) amountBingo[0]++;
	if (check(0, 0, 6, dat2)) amountBingo[1]++;
	if (check(0, size - 1, 4, dat)) amountBingo[0]++;
	if (check(0, size - 1, 4, dat2)) amountBingo[1]++;
}

int** Bingo::getDat2() {
	int** temp = (int**)malloc(sizeof(int*) * size);
	temp[0] = (int*)malloc(sizeof(int) * size * size);
	for (int i = 1; i < size; i++) temp[i] = temp[i - 1] + size;

	for (int i = 0; i < size; i++) {
		for (int j = 0; j < size; j++) {
			temp[i][j] = dat2[i][j];
		}
	}

	return temp;
}