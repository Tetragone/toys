#pragma once
#include "Board.h"

class Omok :
	public Board
{
private:
	int length = 0; // 길이에 따라서 승리의 유무를 따진다. 

protected:
	bool check(int, int, int); // 돌을 둘수 있는지 확인하는 함수.

public:
	Omok();
	~Omok();
	int putStone(char, char); //돌을 놓는 함수 반환값은 0: 진행 -1: 흑돌의 승리 1: 백돌의 승리 2: 무승부
};

