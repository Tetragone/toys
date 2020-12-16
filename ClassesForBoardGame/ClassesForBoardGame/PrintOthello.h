#pragma once
#include "OthelloBoard.h"
class PrintOthello :
	public OthelloBoard
{
private:
	void printBoardOneLine(int) override; // ������ ����ϱ� ���� �Լ�.
	void printMiddleLine(int); // �߰��� ���� ����ϱ� ���� �Լ�. 

public:
	PrintOthello();
	~PrintOthello();
	void printAll() override; // board ���� ����ϱ� ���� �Լ�
};

