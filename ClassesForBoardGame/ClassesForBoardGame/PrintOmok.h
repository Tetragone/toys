#pragma once
#include "NarrowBoard.h"
class PrintOmok :
	public NarrowBoard
{
	void printStone(int) override;
public:
	PrintOmok();
	~PrintOmok();
	void printAll() override; // board ���� ����ϱ� ���� �Լ�
};

