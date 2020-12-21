#include "Render.h"
#include "Logic.h"
#include "WideBoard.h"
#include "Board.h"
#include "Bingo.h"
#include "PrintBingo.h"
#include "Othello.h"
#include "Omok.h"
#include "PrintOmok.h"
#include "PrintOthello.h"
#include "NarrowBoard.h"

// int main() {
// 	int x;
// 	int win;

// 	Bingo b = Bingo(5);
// 	PrintBingo pb = PrintBingo();

// 	do {
// 		pb.setDat(b.getDat());
// 		pb.setDat2(b.getDat2());
// 		pb.printAll();

// 		cout << "input position:";
// 		cin >> x;

// 		win = b.putStone(x, ' ');
// 	} while (win == -1);

// 	pb.setDat(b.getDat());
// 	pb.setDat2(b.getDat2());
// 	pb.printAll();

// 	if (win == 0) cout << "플레이어 1의 승리입니다.\n";
// 	else if (win == 1) cout << "플레이어 2의 승리입니다\n";
// 	else cout << "무승부 입니다!\n";

// 	cin >> x;
// }

int main() {
	char x, y;
	int win;

	Omok om = Omok(16);
	PrintOmok po = PrintOmok();

	do {
		po.setDat(om.getDat());
		po.printAll();

		cout << "input position :";
		cin >> x >> y;

		win = om.putStone(x, y);
	} while (win == -1);

	po.setDat(om.getDat());
	po.printAll();
	if (win == 0) cout << "흑돌의 승리입니다.\n";
	else if (win == 1) cout << "백돌의 승리입니다.\n";
	else cout << "무승부입니다\n";

	cin >> x; // 자동으로 꺼지는 것을 방지하는 코드.
}