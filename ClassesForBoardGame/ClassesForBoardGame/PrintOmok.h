#pragma once
#include "OmokBoard.h"
class PrintOmok :
	public OmokBoard
{
	void printBoardOneLine(int) override; // ������ ����ϱ� ���� �Լ�.
public:
	PrintOmok();
	~PrintOmok();
	void printAll() override; // board ���� ����ϱ� ���� �Լ�
};

