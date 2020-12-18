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

	if (win == 0) cout << "�÷��̾� 1�� �¸��Դϴ�.\n";
	else if (win == 1) cout << "�÷��̾� 2�� �¸��Դϴ�\n";
	else cout << "���º� �Դϴ�!\n";

	cin >> x;
}