#pragma once
#include "Logic.h"
#include <stack>

class Board : public Logic
{
protected: 
	int length;
//	stack<pair<int, int>> progress;
	int turn = 0; // 0: 흑돌 1: 백돌
	int move[8][2] = { {-1 ,1}, {-1, 0}, {-1, -1}, {0, -1}, {1, -1}, {1, 0}, {1, 1}, {0, 1} };
	int spaceStone;
	void nextTurn() { turn = 1 - turn; };
	bool check(int, int, int); // 돌을 둘수 있는지 확인하는 함수.
	
public:
	Board(int);
	~Board();
	virtual int putStone(char, char) { return -1; }; // 돌을 넣는것. 반환값은 -1: 진행 0: 흑돌의 승리 1: 백돌의 승리 2: 무승부
};

