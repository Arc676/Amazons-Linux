// Copyright (C) 2019-21 Arc676/Alessandro Vinciguerra

// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation (version 3)

// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU General Public License for more details.

// You should have received a copy of the GNU General Public License
// along with this program. If not, see <http://www.gnu.org/licenses/>.
// See README and LICENSE for more details

#include "amazons.h"

Amazons::Amazons() {
	board.board = 0;
}

Amazons::~Amazons() {
	clearBoard();
}

void Amazons::clearBoard() {
	if (board.board) {
		boardstate_free(&board);
	}
}

void Amazons::startGame(QVariant whitepos, QVariant blackpos) {
	clearBoard();
	Square wpos[wp];
	Square bpos[bp];
	QList<QVariant> wstart = whitepos.toList();
	QList<QVariant> bstart = blackpos.toList();
	int i = 0;
	for (QList<QVariant>::iterator it = wstart.begin(); it != wstart.end(); it++) {
		int x = (*it).toInt();
		it++;
		int y = (*it).toInt();
		wpos[i] = Square {x, y};
		i++;
	}
	i = 0;
	for (QList<QVariant>::iterator it = bstart.begin(); it != bstart.end(); it++) {
		int x = (*it).toInt();
		it++;
		int y = (*it).toInt();
		bpos[i] = Square {x, y};
		i++;
	}
	boardstate_init(&board, wp, bp, bw, bh, wpos, bpos);
	currentPlayer = WHITE;
	emit redraw();
}

bool Amazons::moveAmazon(int x, int y) {
	Square shot = Square { x, y };
	if (board.board[src.y * board.boardWidth + src.x] == currentPlayer && amazons_move(&board, &src, &dst)) {
		if (amazons_shoot(&board, &dst, &shot)) {
			swapPlayer(&currentPlayer);
			emit redraw();
			return true;
		} else {
			amazons_move(&board, &dst, &src);
		}
	}
	return false;
}

Amazons::QSquareState Amazons::gameIsOver() {
	if (!updateRegionMap(&board)) {
		countControlledSquares(&board, &whiteSquares, &blackSquares);
		if (whiteSquares > blackSquares) {
			return QWHITE;
		} else {
			return QBLACK;
		}
	}
	if (playerHasValidMove(&board, currentPlayer)) {
		return QEMPTY;
	}
	return currentPlayer == BLACK ? QWHITE : QBLACK;
}

bool Amazons::whiteToPlay() {
	return currentPlayer == WHITE;
}

void Amazons::setGameProperties(int wp, int bp, int bw, int bh) {
	this->wp = wp;
	this->bp = bp;
	this->bw = bw;
	this->bh = bh;
	emit boardSizeChanged();
}

bool Amazons::setSrc(int x, int y) {
	if (board.board[y * board.boardWidth + x] == currentPlayer) {
		src = Square { x, y };
		emit redraw();
		return true;
	}
	return false;
}

bool Amazons::setDst(int x, int y) {
	Square dst = Square { x, y };
	if (isValidMove(&board, &src, &dst)) {
		this->dst = dst;
		emit redraw();
		return true;
	}
	return false;
}

int Amazons::getBoardHeight() {
	return bh;
}

int Amazons::getBoardWidth() {
	return bw;
}

int Amazons::getSquare(ClickState square, int axis) {
	if (square == SOURCE) {
		return axis == 1 ? src.x : src.y;
	}
	return axis == 1 ? dst.x : dst.y;
}

Amazons::QSquareState Amazons::getSquareState(int x, int y) {
	if (!board.board) {
		return QEMPTY;
	}
	switch (board.board[y * board.boardWidth + x]) {
		case BLACK:
			return QBLACK;
		case WHITE:
			return QWHITE;
		case ARROW:
			return QARROW;
		default:
			return QEMPTY;
	}
}
