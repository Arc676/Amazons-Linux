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

#ifndef AMAZONS_H
#define AMAZONS_H

#include <QObject>
#include <QVariant>
#include <QList>

#include "libamazons.h"

class Amazons: public QObject {
	Q_OBJECT

	BoardState board;
	SquareState currentPlayer = WHITE;

	int wp, bp, bw, bh;
	Square src, dst, shot;

	void clearBoard();
public:
	Amazons();
	~Amazons();

	enum ClickState : int {
		SOURCE = 0, DESTINATION, SHOT
	};
	Q_ENUMS(ClickState)

	enum QSquareState : int {
		QWHITE, QBLACK, QARROW, QEMPTY
	};
	Q_ENUMS(QSquareState)

	Q_INVOKABLE void startGame(QVariant whitepos, QVariant blackpos);

	Q_INVOKABLE bool moveAmazon(int x, int y);

	Q_INVOKABLE int gameIsOver();

	Q_INVOKABLE bool whiteToPlay();

	Q_INVOKABLE void setGameProperties(int wp, int bp, int bw, int bh);

	Q_INVOKABLE bool setSrc(int x, int y);

	Q_INVOKABLE bool setDst(int x, int y);

	Q_INVOKABLE int getBoardHeight();

	Q_INVOKABLE int getBoardWidth();

	Q_INVOKABLE int getSquare(ClickState square, int axis);

	Q_INVOKABLE QSquareState getSquareState(int x, int y);
signals:
	void redraw();
};

#endif
