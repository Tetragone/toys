#pragma once
#include "Render.h"
class OthelloBoard : public Render
{
protected:
	void printUpBoard() override;

public:
	OthelloBoard();
	~OthelloBoard();
};

