// Copyright (C) 2019 Arc676/Alessandro Vinciguerra <alesvinciguerra@gmail.com>

// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation (version 3)

// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.

// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.

import QtQuick 2.4
import QtQuick.Layouts 1.1
import Ubuntu.Components 1.3

Page {
	id: setupPage
	header: DefaultHeader {}
	
	property bool areSFXEnabled: true

	function parseWithDefault(text, def) {
		var parsed = parseInt(text)
		if (isNaN(parsed) || parsed <= 0) {
			return def
		}
		return parsed
	}

	function getAmazons(player) {
		return parseWithDefault(player === 1 ? p1amazons.text : p2amazons.text, 4)
	}

	function getBoardSize(axis) {
		return parseWithDefault(axis === 1 ? boardHeight.text : boardWidth.text, 10)
	}

	Column {
		anchors {
			top: header.bottom
			topMargin: margin
			left: parent.left
			leftMargin: margin
			right: parent.right
			rightMargin: margin
			bottom: parent.bottom
			bottomMargin: margin
		}
		spacing: margin

		Row {
			width: parent.width
			spacing: margin

			Label {
				id: p1lbl
				text: "Player 1 Amazons"
				anchors.verticalCenter: p1amazons.verticalCenter
			}

			TextField {
				id: p1amazons
				placeholderText: "4"
				width: parent.width - p1lbl.width - margin
			}
		}

		Row {
			width: parent.width
			spacing: margin

			Label {
				id: p2lbl
				text: "Player 2 Amazons"
				anchors.verticalCenter: p2amazons.verticalCenter
			}

			TextField {
				id: p2amazons
				placeholderText: "4"
				width: parent.width - p2lbl.width - margin
			}
		}

		Row {
			width: parent.width
			spacing: margin

			Label {
				id: bwlbl
				text: "Board width"
				anchors.verticalCenter: boardWidth.verticalCenter
			}

			TextField {
				id: boardWidth
				placeholderText: "10"
				width: parent.width - bwlbl.width - margin
			}
		}

		Row {
			width: parent.width
			spacing: margin

			Label {
				id: bhlbl
				text: "Board height"
				anchors.verticalCenter: boardHeight.verticalCenter
			}

			TextField {
				id: boardHeight
				placeholderText: "10"
				width: parent.width - bhlbl.width - margin
			}
		}

		/*Row {
			width: parent.width
			spacing: margin

			CheckBox {
				id: enableSFX
				text: i18n.tr("Enable sound effects")
				checked: true

				onClicked: areSFXEnabled = checked
			}
		}*/
	}
}
