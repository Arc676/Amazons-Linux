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
	property var initialPositions: []
	property int p1count: 0
	property int p2count: 0
	property int clickedSquare: 0

	function undoPlacement() {
		if (isSettingUp) {
			if (pickedPositions > 0) {
				pickedPositions--
				initialPositions.pop()
				initialPositions.pop()
			}
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

	function newStandardGame() {
		var wstart = [3, 0, 0, 3, 0, 6, 3, 9]
		var bstart = [6, 0, 9, 3, 9, 6, 6, 9]
		Amazons.setGameProperties(4, 4, 10, 10)
		gameViewPage.p1count = 4
		gameViewPage.p2count = 4
		Amazons.startGame(wstart, bstart)
	}

	Connections {
		target: Amazons

		onRedraw: gameCanvas.requestPaint()
		onBoardSizeChanged: {
			gameCanvas.width = Amazons.getBoardWidth() * gameCanvas.squareSize
			gameCanvas.height = Amazons.getBoardHeight() * gameCanvas.squareSize
			flick.contentWidth = gameCanvas.width
			flick.contentHeight = gameCanvas.height
			gameCanvas.requestPaint()
		}
	}

	Component {
		id: confirmRestartNotif

		ConfirmDialog {
			onRestart: {
				var wp = setup.getAmazons(1)
				var bp = setup.getAmazons(2)
				var bh = setup.getBoardSize(1)
				var bw = setup.getBoardSize(2)
				gameViewPage.isSettingUp = true
				gameViewPage.pickedPositions = 0
				gameViewPage.initialPositions = []
				Amazons.setGameProperties(wp, bp, bw, bh)
				gameViewPage.p1count = wp
				gameViewPage.p2count = bp
				stateLabel.text = i18n.tr("Tap initial starting positions for first player")
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
		clip: true

		Canvas {
			id: gameCanvas
			anchors {
				top: parent.top
				left: parent.left
			}

			property real squareSize: units.gu(5)

			onPaint: {
				var ctx = gameCanvas.getContext('2d')
				ctx.fillStyle = "#FFFFFF"
				ctx.fillRect(0, 0, gameCanvas.width, gameCanvas.height)
				ctx.fillStyle = "#7F7F7F"
				for (var x = 0; x < Amazons.getBoardWidth(); x++) {
					for (var y = 0; y < Amazons.getBoardHeight(); y++) {
						if ((x + y) % 2 == 0) {
							ctx.fillRect(x * squareSize, y * squareSize, squareSize, squareSize)
						}
					}
				}
				if (gameViewPage.isSettingUp) {
					for (var i = 0; i < gameViewPage.pickedPositions * 2; i += 2) {
						var x = gameViewPage.initialPositions[i]
						var y = gameViewPage.initialPositions[i + 1]
						if (i < gameViewPage.p1count * 2) {
							ctx.fillStyle = "#AAAAAA"
						} else {
							ctx.fillStyle = "#000000"
						}
						ctx.fillRect(x * squareSize, y * squareSize, squareSize, squareSize)
					}
				} else {
					for (var x = 0; x < Amazons.getBoardWidth(); x++) {
						for (var y = 0; y < Amazons.getBoardHeight(); y++) {
							switch (Amazons.getSquareState(x, y)) {
								case Amazons.QWHITE:
									ctx.drawImage("sprites/P1.png", x * squareSize, y * squareSize, squareSize, squareSize)
									break
								case Amazons.QBLACK:
									ctx.drawImage("sprites/P2.png", x * squareSize, y * squareSize, squareSize, squareSize)
									break
								case Amazons.QARROW:
									ctx.drawImage("sprites/Occupied.png", x * squareSize, y * squareSize, squareSize, squareSize)
									break
								default:
									break
							}
						}
					}
					switch (gameViewPage.clickedSquare) {
						case 2:
							ctx.fillStyle = "#FF0000"
							var xd = Amazons.getSquare(Amazons.DESTINATION, 1)
							var yd = Amazons.getSquare(Amazons.DESTINATION, 2)
							ctx.fillRect(xd * squareSize, yd * squareSize, squareSize, squareSize)
						case 1:
							//ctx.fillStyle = "rgba(0, 255, 0, 0.5)"
							ctx.fillStyle = "#00FF00"
							var xs = Amazons.getSquare(Amazons.SOURCE, 1)
							var ys = Amazons.getSquare(Amazons.SOURCE, 2)
							ctx.fillRect(xs * squareSize, ys * squareSize, squareSize, squareSize)
						default:
							break
					}
				}
			}

			MouseArea {
				id: gameTapArea
				anchors.fill: parent

				onReleased: {
					var squareSize = gameCanvas.squareSize
					var x = mouse.x / squareSize
					var y = mouse.y / squareSize
					if (gameViewPage.isSettingUp) {
						for (var i = 0; i < gameViewPage.pickedPositions * 2; i += 2) {
							if (gameViewPage.initialPositions[i] == x &&
								gameViewPage.initialPositions[i + 1] == y) {
								return;
							}
						}
						gameViewPage.initialPositions.push(Math.floor(x))
						gameViewPage.initialPositions.push(Math.floor(y))
						gameViewPage.pickedPositions++
						if (gameViewPage.pickedPositions >= gameViewPage.p1count + gameViewPage.p2count) {
							var wstart = gameViewPage.initialPositions.slice(0, gameViewPage.p1count * 2)
							var bstart = gameViewPage.initialPositions.slice(gameViewPage.p1count * 2)
							Amazons.startGame(wstart, bstart)
							gameViewPage.isSettingUp = false
							stateLabel.text = i18n.tr("Bows to move")
						} else {
							if (gameViewPage.pickedPositions < gameViewPage.p1count) {
								stateLabel.text = i18n.tr("Tap initial starting positions for first player")
							} else {
								stateLabel.text = i18n.tr("Tap initial starting positions for second player")
							}
							gameCanvas.requestPaint()
						}
					} else {
						switch (gameViewPage.clickedSquare) {
							case 0:
								if (!Amazons.setSrc(x, y)) {
									return
								}
								break
							case 1:
								if (!Amazons.setDst(x, y)) {
									return
								}
								break
							case 2:
							default:
								if (!Amazons.moveAmazon(x, y)) {
									return
								}
								var winner = Amazons.gameIsOver()
								if (winner === 1) {
									stateLabel.text = i18n.tr("Bows win!")
								} else if (winner === 2) {
									stateLabel.text = i18n.tr("Spears win!")
								} else {
									if (Amazons.whiteToPlay()) {
										stateLabel.text = i18n.tr("Bows to move")
									} else {
										stateLabel.text = i18n.tr("Spears to move")
									}
								}
								break
						}
						gameViewPage.clickedSquare = (gameViewPage.clickedSquare + 1) % 3
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
		gameCanvas.loadImage("sprites/P1.png")
		gameCanvas.loadImage("sprites/P2.png")
		gameCanvas.loadImage("sprites/Occupied.png")
		newStandardGame()
	}
}
