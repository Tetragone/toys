#pragma once
#include "Logic.h"
#include <stack>

class Board : public Logic
{
protected: 
	int length;
//	stack<pair<int, int>> progress;
	int turn = 0; // 0: �浹 1: �鵹
	int move[8][2] = { {-1 ,1}, {-1, 0}, {-1, -1}, {0, -1}, {1, -1}, {1, 0}, {1, 1}, {0, 1} };
	int spaceStone;
	void nextTurn() { turn = 1 - turn; };
	bool check(int, int, int); // ���� �Ѽ� �ִ��� Ȯ���ϴ� �Լ�.
	
public:
	Board(int);
	~Board();
	virtual int putStone(char, char) { return -1; }; // ���� �ִ°�. ��ȯ���� -1: ���� 0: �浹�� �¸� 1: �鵹�� �¸� 2: ���º�
};

