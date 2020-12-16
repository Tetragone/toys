#pragma once
#include "OmokBoard.h"
class PrintOmok :
	public OmokBoard
{
	void printBoardOneLine(int) override; // 한줄을 출력하기 위한 함수.
public:
	PrintOmok();
	~PrintOmok();
	void printAll() override; // board 전부 출력하기 위한 함수
};

