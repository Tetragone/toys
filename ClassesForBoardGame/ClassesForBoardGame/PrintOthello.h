#pragma once
#include "WideBoard.h"
class PrintOthello :
	public WideBoard
{
private:
	void printBoardOneLine(int) override; // ������ ����ϱ� ���� �Լ�.

public:
	PrintOthello();
	~PrintOthello();
	void printAll() override; // board ���� ����ϱ� ���� �Լ�
};

