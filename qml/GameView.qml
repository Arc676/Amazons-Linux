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
import Ubuntu.Components.Popups 1.3
import QtMultimedia 5.8

import Amazons 1.0

Page {
	id: gameViewPage
	anchors.fill: parent

	property SetupView setup

	property bool isSettingUp: false

	property int pickedPositions: 0
	property int clickedSquare: 0

	function undoPlacement() {
		if (isSettingUp) {
			pickedPositions--
		} else {
			clickedSquare = 0
		}
		gameCanvas.requestPaint()
	}

	header: DefaultHeader {}

	function playSound(sfx) {
		if (setup.areSFXEnabled) {
			sfx.play()
		}
	}

	function restartGame() {
		PopupUtils.open(confirmRestartNotif, gameViewPage, {})
	}

	Connections {
		target: Amazons
	}

	Component {
		id: confirmRestartNotif

		ConfirmDialog {
			onRestart: {
				var wp = setup.getAmazons(1)
				var bp = setup.getAmazons(2)
				var bw = setup.getAmazons(1)
				var bh = setup.getAmazons(2)
				gameViewPage.isSettingUp = true
				gameCanvas.requestPaint()
				Amazons.setGameProperties(wp, bp, bw, bh)
			}
		}
	}

	Flickable {
		id: flick
		anchors {
			top: header.bottom
			topMargin: margin
			left: parent.left
			leftMargin: margin
			right: parent.right
			rightMargin: margin
			bottom: stateLabel.top
			bottomMargin: margin
		}

		Canvas {
			id: gameCanvas
			anchors.fill: parent

			property real squareSize: 40

			onPaint: {
				var ctx = gameCanvas.getContext('2d')
				for (int x = 0; x < Amazons.getBoardWidth(); x++) {
					for (int y = 0; y < Amazons.getBoardHeight(); y++) {
						if ((x + y) % 2 == 0) {
							ctx.fillRect(x * squareSize, y * squareSize, squareSize, squareSize)
						}
					}
				}
			}

			MouseArea {
				id: gameTapArea
				anchors.fill: parent

				onReleased: {
					var x = (mouse.x + flick.contentX) / squareSize
					var y = (mouse.y + flick.contentY) / squareSize
					if (gameViewPage.isSettingUp) {
					} else {
						switch (gameViewPage.clickedSquare) {
							case 0:
								if (!Amazons.setSrc(x, y)) {
									return;
								}
								break;
							case 1:
								if (!Amazons.setDst(x, y)) {
									return;
								}
								break;
							case 2:
							default:
						}
					}
				}
			}
		}
	}

	Label {
		id: stateLabel
		anchors {
			left: parent.left
			leftMargin: margin
			right: parent.right
			rightMargin: margin
			bottom: parent.bottom
			bottomMargin: margin
		}

		text: i18n.tr("Bows to move")
	}

	Component.onCompleted: {
		var wstart = [3, 0, 0, 3, 0, 6, 3, 9]
		var bstart = [6, 0, 9, 3, 9, 6, 6, 9]
		Amazons.setGameProperties(4, 4, 10, 10)
		Amazons.startGame(wstart, bstart)
		gameCanvas.requestPaint()
	}
}
