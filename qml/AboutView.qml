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

Page {
	id: aboutPage
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
				text: "Game of the Amazons - " + i18n.tr("written by Arc676/Alessandro Vinciguerra. Project available under") + " GPLv3. Copyright 2019-20 Arc676/Alessandro Vinciguerra <alesvinciguerra@gmail.com>"
			}

			WrappingLabel {
				text: i18n.tr("This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation (version 3).")
			}

			WrappingLabel {
				text: i18n.tr("This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.")
			}

			WrappingLabel {
				text: i18n.tr("For the full license text, visit the <a href='https://github.com/Arc676/Amazons-Linux'>repository</a> or the <a href='http://www.gnu.org/licenses/'>GNU licenses page</a>")
			}

			WrappingLabel {
				text: i18n.tr("%1 assets").arg("<a href='https://creativecommons.org/licenses/by-nc-sa/4.0/'>CC BY-NC-SA 4.0</a>")
				textSize: Label.Large
			}

			WrappingLabel {
				text: i18n.tr("All assets by Arc676/Alessandro Vinciguerra adapted from CC0 assets by %1").arg("<a href='https://opengameart.org/content/rpg-itemterraincharacter-sprites-ice-insignia'>rcorre</a>")
			}
		}
	}
}
