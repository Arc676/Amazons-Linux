// Copyright (C) 2019 Arc676/Alessandro Vinciguerra <alesvinciguerra@gmail.com>

// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation (version 3)

// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.

// You should have received a copy of the GNU General Public License
// along with this program. If not, see <http://www.gnu.org/licenses/>.

import QtQuick 2.4
import QtQuick.Layouts 1.1
import Ubuntu.Components 1.3

Page {
	id: rulesPage
	header: DefaultHeader {}

	ScrollView {
		id: scroll
		anchors {
			top: header.bottom
			topMargin: margin
			left: parent.left
			leftMargin: margin
			right: parent.right
			rightMargin: margin
			bottom: parent.bottom
		}

		Column {
			width: scroll.width
			spacing: margin

			WrappingLabel {
				text: i18n.tr("Gameplay rules")
			}

			WrappingLabel {
				text: i18n.tr("Amazons is a game invented in 1988 by Walter Zamkauskas of Argentina. It's similar to go and chess. Two players each control a number of Amazons. These can move any number of squares in any direction like chess queens. After moving, they shoot an arrow which permanently occupies the tile on which it lands. The arrow can land on any square accessible by a chess-queen-like move from the Amazon's new location. Amazons and arrows cannot move across a square if it is occupied by an arrow or another Amazon. The first player unable to make a legal move loses. Equivalently, the last player able to make a legal move wins the game.")
			}

			WrappingLabel {
				text: i18n.tr("The Game of the Amazons can be played with any number of Amazons and on any board size or shape. You can configure the game parameters in the game settings. The standard configuration involves 4 Amazons for each player on a 10x10 grid. If the entirety of the board does not fit on screen, you can drag to view different areas of the board. The player represented by the bows always plays first. At the bottom of the screen, the current player is indicated. To make a move, tap an Amazon you control, a valid destination square, and a square to which to shoot. Tapping an invalid square at any point will not affect the app state.")
			}

			WrappingLabel {
				text: i18n.tr("Tap the clockwise-facing reset button to start a new game using the standard configuration. This is also the configuration used when the app is launched. Tap the counterclockwise-facing reset button to start a new game with a custom starting configuration. The parameters are set in the game settings. During a game, tap the undo button to clear your square selections and start over. It is not currently possible to undo a completed move. While setting up a custom game, tap the undo button to undo the last selection.")
			}

			WrappingLabel {
				text: i18n.tr("For more details, please refer to the <a href='https://en.wikipedia.org/wiki/Game_of_the_Amazons'>Wikipedia page</a> or <a href='https://www.youtube.com/watch?v=kjSOSeRZVNg'>the Numberphile YouTube video</a>.")
			}
		}
	}
}
