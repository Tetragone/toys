#pragma once
#include "Render.h"
class NarrowBoard : public Render
{
protected:
	void printUpBoard() override;
	void printBoardOneLine(int) override;
	virtual void printStone(int) {};
public:
	NarrowBoard();
	~NarrowBoard();
};

