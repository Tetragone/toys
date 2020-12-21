#pragma once
#include "NarrowBoard.h"
class PrintOmok :
	public NarrowBoard
{
	void printStone(int) override;
public:
	PrintOmok();
	~PrintOmok();
	void printAll() override; // board 전부 출력하기 위한 함수
};

