#pragma once
#include "Board.h"

class Omok :
	public Board
{
private:
	int length = 0; // ���̿� ���� �¸��� ������ ������. 

protected:
	bool check(int, int, int); // ���� �Ѽ� �ִ��� Ȯ���ϴ� �Լ�.

public:
	Omok();
	~Omok();
	int putStone(char, char); //���� ���� �Լ� ��ȯ���� 0: ���� -1: �浹�� �¸� 1: �鵹�� �¸� 2: ���º�
};

