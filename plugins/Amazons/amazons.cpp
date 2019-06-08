// Copyright (C) 2019 Arc676/Alessandro Vinciguerra

// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation (version 3)

// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.

// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.
// See README and LICENSE for more details

#include "amazons.h"

Amazons::~Amazons() {
	if (board.board) {
		boardstate_free(&board);
	}
}

void Amazons::startGame(QVariant whitepos, QVariant blackpos) {
	Square wpos[wp], bpos[bp];
	QList<QVariant> wstart = whitepos.toList();
	QList<QVariant> bstart = blackpos.toList();
	int i = 0;
	for (QList<QVariant>::iterator it = wstart.begin(); it != wstart.end(); it++) {
		int x = (*it).toInt();
		it++;
		int y = (*it).toInt();
		wpos[i] = {x, y};
		i++;
	}
	i = 0;
	for (QList<QVariant>::iterator it = bstart.begin(); it != bstart.end(); it++) {
		int x = (*it).toInt();
		it++;
		int y = (*it).toInt();
		bpos[i] = {x, y};
		i++;
	}
	boardstate_init(&board, wp, bp, bw, bh, wpos, bpos);
}

bool Amazons::moveAmazon(int x, int y, bool whitePlayer) {
	SquareState player = whitePlayer ? WHITE : BLACK;
	Square shot = Square { x, y };
	if (board.board[xs * board.boardWidth + ys] == player && amazons_move(&board, &src, &dst)) {
		if (amazons_shoot(&board, &dst, &shot)) {
			swapPlayer(&currentPlayer);
			return true;
		} else {
			amazons_move(&board, &dst, &src);
		}
	}
	return false;
}

int Amazons::gameIsOver() {
	if (playerHasValidMove(&board, currentPlayer)) {
		return 0;
	}
	return currentPlayer == BLACK ? 1 : 2;
}

void Amazons::setGameProperties(int wp, int bp, int bw, int bh) {
	this->wp = wp;
	this->bp = bp;
	this->bw = bw;
	this->bh = bh;
}

bool Amazons::setSrc(int x, int y) {
	if (board.board[x * board.boardWidth + y] == currentPlayer) {
		src = Square { x, y };
		return true;
	}
	return false;
}

bool Amazons::setDst(int x, int y) {
	Square dst = Square { x, y };
	if (isValidMove(&board, &src, &dst)) {
		this->dst = dst;
		return true;
	}
	return false;
}
