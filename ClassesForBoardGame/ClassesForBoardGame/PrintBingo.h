#pragma once
#include "WideBoard.h"
class PrintBingo :
	public WideBoard
{
private:
	int** dat2;
	void printBoardOneLine(int, int**);

public:
	PrintBingo();
	~PrintBingo();
	void printAll();
	void setDat2(int** input) { dat2 = input; };
};

