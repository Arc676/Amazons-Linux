// Copyright (C) 2019-20 Arc676/Alessandro Vinciguerra <alesvinciguerra@gmail.com>

// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation (version 3)

// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU General Public License for more details.

// You should have received a copy of the GNU General Public License
// along with this program. If not, see <http://www.gnu.org/licenses/>.

import QtQuick 2.4
import QtQuick.Layouts 1.1
import Ubuntu.Components 1.3

MainView {
	id: root
	objectName: 'mainView'
	applicationName: 'amazons.arc676'
	automaticOrientation: true

	width: units.gu(45)
	height: units.gu(75)
	property real margin: units.gu(2)

	PageStack {
		id: pageViewer
		anchors.fill: parent

		property SetupView setupView: SetupView {
			visible: false
		}

		property GameView gameView: GameView {
			setup: pageViewer.setupView
			visible: false
		}

		property AboutView aboutView: AboutView {
			visible: false
		}

		property RulesView rulesView: RulesView {
			visible: false
		}

		Component.onCompleted: {
			pageViewer.clear()
			pageViewer.push(gameView)
		}
	}
}
