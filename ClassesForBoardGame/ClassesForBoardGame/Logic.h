#pragma once
class Logic
{
protected:
	int** dat;
	int size;
	int transInputToInt(char); // 입력 받은 문자j열을 숫자로 바꿔주는 함수.

public:
	Logic();
	~Logic();
	int** getDat();
	int getSize() { return size; };
	virtual int putStone(char, char) { return -1; };
};
// 게임의 대 전제 -> 오목은 무승부가 없다. 
// 오델로는 한명이 못두는 경우의 수는 제외한다. 