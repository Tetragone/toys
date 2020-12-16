#pragma once
#include "Board.h"
class Othello :
	public Board
{
private:
	int whiteStone; // 백돌의 개수
	int blackStone; // 흑돌의 개수
	void totalStone(); //spaceStone(빈공간)이 0일때 whitestone(백돌), blackstone(흑돌)의 개수를 새는 함수. 
	int checkAll(); // 현재 순서의 돌이 둘 수 있는 자리의 개수를 반환하는 함수
	bool swapStone(int, int);

protected:
	bool check(int, int, int); // 돌을 둘수 있는지 확인하는 함수.

public:
	Othello();
	~Othello();
	int putStone(char, char); //돌을 놓는 함수 반환값은 0: 진행 -1: 흑돌의 승리 1: 백돌의 승리 2: 무승부
};

