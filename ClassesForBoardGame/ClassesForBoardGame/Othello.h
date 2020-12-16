#pragma once
#include "Board.h"
class Othello :
	public Board
{
private:
	int whiteStone; // �鵹�� ����
	int blackStone; // �浹�� ����
	void totalStone(); //spaceStone(�����)�� 0�϶� whitestone(�鵹), blackstone(�浹)�� ������ ���� �Լ�. 
	int checkAll(); // ���� ������ ���� �� �� �ִ� �ڸ��� ������ ��ȯ�ϴ� �Լ�
	bool swapStone(int, int);

protected:
	bool check(int, int, int); // ���� �Ѽ� �ִ��� Ȯ���ϴ� �Լ�.

public:
	Othello();
	~Othello();
	int putStone(char, char); //���� ���� �Լ� ��ȯ���� 0: ���� -1: �浹�� �¸� 1: �鵹�� �¸� 2: ���º�
};

