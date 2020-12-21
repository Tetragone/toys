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

// 	if (win == 0) cout << "�÷��̾� 1�� �¸��Դϴ�.\n";
// 	else if (win == 1) cout << "�÷��̾� 2�� �¸��Դϴ�\n";
// 	else cout << "���º� �Դϴ�!\n";

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
	if (win == 0) cout << "�浹�� �¸��Դϴ�.\n";
	else if (win == 1) cout << "�鵹�� �¸��Դϴ�.\n";
	else cout << "���º��Դϴ�\n";

	cin >> x; // �ڵ����� ������ ���� �����ϴ� �ڵ�.
}