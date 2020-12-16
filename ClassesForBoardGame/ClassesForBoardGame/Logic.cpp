#include "Logic.h"
#include <cstdlib>
#include <cstring>

Logic::Logic()
{
}


Logic::~Logic()
{
}

int Logic::transInputToInt(char input) {
	return (48 <= input && input <= 57) ? input - 48 : input - 87;
}

int** Logic::getDat() {
	int** temp = (int**)malloc(sizeof(int*) * size);
	temp[0] = (int*)malloc(sizeof(int) * size * size);
	for (int i = 1; i < size; i++) temp[i] = temp[i - 1] + size;
	
	for (int i = 0; i < size; i++) {
		for (int j = 0; j < size; j++) {
			temp[i][j] = dat[i][j];
		}
	}

	return temp;
}