#pragma once
#include "Logic.h"
class Board : public Logic
{
protected: 
	int turn = 0; // 0: �浹 1: �鵹
	int move[8][2] = { {-1 ,1}, {-1, 0}, {-1, -1}, {0, -1}, {1, -1}, {1, 0}, {1, 1}, {0, 1} };
	int spaceStone;
	void nextTurn() { turn = 1 - turn; };
	virtual bool check(int, int, int) { return false; }; // ���� �Ѽ� �ִ��� Ȯ���ϴ� �Լ�.

public:
	Board();
	~Board();
	virtual int putStone(char, char) { return -1; }; // ���� �ִ°�. ��ȯ���� -1: ���� 0: �浹�� �¸� 1: �鵹�� �¸� 2: ���º�
};

