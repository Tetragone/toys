#include <iostream>

using namespace std;

#pragma once

class Render
{
protected:
	int **dat;
	int size;
	string line[11] = {
		 "│", "─",
		 "┌", "┬", "┐",
		 "├", "┼", "┤",
		 "└", "┴", "┘"
	};
	string stone[2] = { "○","●" };
	virtual void printUpBoard() {}; //위에 숫자 
	virtual void printBoardOneLine(int) {}; // 한줄을 출력하기 위한 함수.
	
public:
	Render();
	~Render();
	void setDat(int **input) { dat = input; };
	virtual void printAll() {}; // board 전부 출력하기 위한 함수 
};
// board자체, 오목, 오델로, -> 이렇게 나눌수 있을꺼 같음.