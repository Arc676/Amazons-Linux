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

public:
	~Amazons();

	Q_INVOKABLE void startGame(int wp, int bp, int bw, int bh, QVariant whitepos, QVariant blackpos);

	Q_INVOKABLE bool moveAmazon(int xs, int ys, int xd, int yd, int xx, int yx, bool whitePlayer);

	Q_INVOKABLE int gameIsOver();
};

#endif
