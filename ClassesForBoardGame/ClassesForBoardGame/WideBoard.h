#pragma once
#include "Render.h"
class WideBoard : public Render
{
protected:
	void printUpBoard() override;
	void printMiddleLine(int location);

public:
	WideBoard();
	~WideBoard();
};

