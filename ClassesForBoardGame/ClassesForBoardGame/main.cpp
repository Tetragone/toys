#include "PrintOmok.h"
#include "PrintOthello.h"
#include "Render.h"
#include "Logic.h"
#include "Omok.h"
#include "Othello.h"
#include "OmokBoard.h"
#include "OthelloBoard.h"
#include "Board.h"

int main() {
	int mode;
	char x, y;
	int win;

	cout << "1. Omok 2.Othello : ";
	cin >> mode;

	if (mode == 1) {
		Omok omok = Omok();
		PrintOmok printomok = PrintOmok();

		do {
			printomok.setDat(omok.getDat());
			printomok.printAll();

			cout << "input position:";
			cin >> x >> y;

			win = omok.putStone(x, y);
		} while (win == -1);
//		logic = static_cast<Omok>(omok);
//		render = static_cast<PrintOmok>(printomok);
	}
	else {
		Othello othello = Othello();
		PrintOthello printothello = PrintOthello();

		do {
			printothello.setDat(othello.getDat());
			printothello.printAll();

			cout << "input position:";
			cin >> x >> y;

			win = othello.putStone(x, y);
		} while (win == -1);
//		logic = static_cast<Othello>(othello);
//		render = static_cast<PrintOthello>(printothello);
	}
}