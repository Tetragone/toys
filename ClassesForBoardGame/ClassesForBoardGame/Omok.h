#pragma once
#include "Board.h"

class Omok :
	public Board
{
public:
	Omok(int);
	int putStone(char, char); //���� ���� �Լ� ��ȯ���� 0: ���� -1: �浹�� �¸� 1: �鵹�� �¸� 2: ���º�
};

