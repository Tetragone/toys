#include <iostream>

using namespace std;

#pragma once

class Render
{
protected:
	int **dat;
	int size;
	string line[11] = {
		 "��", "��",
		 "��", "��", "��",
		 "��", "��", "��",
		 "��", "��", "��"
	};
	string stone[2] = { "��","��" };
	virtual void printUpBoard() {}; //���� ���� 
	virtual void printBoardOneLine(int) {}; // ������ ����ϱ� ���� �Լ�.
	
public:
	Render();
	~Render();
	void setDat(int **input) { dat = input; };
	virtual void printAll() {}; // board ���� ����ϱ� ���� �Լ� 
};
// board��ü, ����, ������, -> �̷��� ������ ������ ����.