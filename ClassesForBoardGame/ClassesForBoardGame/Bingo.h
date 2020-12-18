#pragma once
#include "Board.h"
class Bingo :
	public Board
{
private:
	int **dat2;
	int size;
	int amountBingo[2];
	void init(int**);
	bool check(int, int, int, int**);
	void checkAll();

public:
	Bingo(int);
	~Bingo();
	int putStone(char, char);
	int** getDat2();
};

