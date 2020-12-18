#pragma once
#include "WideBoard.h"
class PrintOthello :
	public WideBoard
{
private:
	void printBoardOneLine(int) override; // 한줄을 출력하기 위한 함수.

public:
	PrintOthello();
	~PrintOthello();
	void printAll() override; // board 전부 출력하기 위한 함수
};

