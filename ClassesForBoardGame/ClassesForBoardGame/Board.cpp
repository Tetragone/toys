#include "Board.h"
#include <cstring>
#include <cstdlib>
#include <iostream>

using namespace std;

Board::Board(int s)
{	
	size = s;

	dat = (int**)malloc(sizeof(int*) * size);
	dat[0] = (int*)malloc(sizeof(int) * size * size);
	for (int i = 1; i < size; i++) dat[i] = dat[i - 1] + size;
	memset(dat[0], 0, sizeof(int) * size * size);
}


Board::~Board()
{
	free(dat[0]);
	free(dat);
}

bool Board::check(int x, int y, int index) {
	int tempX = x;
	int tempY = y;
	length = 0;

	do {
		tempX += move[index][0];
		tempY += move[index][1];
		length++;

		if (tempX >= size || tempY >= size || tempX < 0 || tempY < 0) return false;
//		progress.push(pair<int, int>(tempX, tempY));
	} while (dat[tempX][tempY] == turn);

	if (length && dat[x][y] == turn) return true;
	else return false;
}