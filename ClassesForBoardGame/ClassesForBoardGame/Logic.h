#pragma once
class Logic
{
protected:
	int** dat;
	int size;
	int transInputToInt(char); // �Է� ���� ����j���� ���ڷ� �ٲ��ִ� �Լ�.

public:
	Logic();
	~Logic();
	int** getDat();
	int getSize() { return size; };
	virtual int putStone(char, char) { return -1; };
};
// ������ �� ���� -> ������ ���ºΰ� ����. 
// �����δ� �Ѹ��� ���δ� ����� ���� �����Ѵ�. 