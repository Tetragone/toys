#pragma once
#include "Board.h"

class Omok :
	public Board
{
public:
	Omok(int);
	int putStone(char, char); //돌을 놓는 함수 반환값은 0: 진행 -1: 흑돌의 승리 1: 백돌의 승리 2: 무승부
};

