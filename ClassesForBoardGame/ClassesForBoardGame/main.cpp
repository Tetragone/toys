#include "Render.h"
#include "Logic.h"
#include "WideBoard.h"
#include "Board.h"
#include "Bingo.h"
#include "PrintBingo.h"

int main() {
	int x;
	int win;
	
	Bingo b = Bingo(5);
	PrintBingo pb = PrintBingo();

	do {
		pb.setDat(b.getDat());
		pb.setDat2(b.getDat2());
		pb.printAll();

		cout << "input position:";
		cin >> x;

		win = b.putStone(x, ' ');
	} while (win == -1);

	pb.setDat(b.getDat());
	pb.setDat2(b.getDat2());
	pb.printAll();

	if (win == 0) cout << "플레이어 1의 승리입니다.\n";
	else if (win == 1) cout << "플레이어 2의 승리입니다\n";
	else cout << "무승부 입니다!\n";

	cin >> x;
}