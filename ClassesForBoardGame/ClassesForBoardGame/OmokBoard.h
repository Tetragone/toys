#pragma once
#include "Render.h"
class OmokBoard : public Render
{
protected:
	void printUpBoard() override;
public:
	OmokBoard();
	~OmokBoard();
};

