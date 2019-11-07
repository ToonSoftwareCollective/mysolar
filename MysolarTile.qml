import QtQuick 2.1
//import qb.base 1.0
import qb.components 1.0

Tile {
	id: mySolarTile
//	tileSize: tilesize_2X1

	/// Will be called when widget instantiated
	function init() {}

	onClicked: {
		if (app.mySolarConfig) {
			app.mySolarConfig.show();
		}
	}

	Text {
		id: txtTotalActualPower
		text: app.totalActualPower + "W"
		color: colors.clockTileColor
		anchors {
			horizontalCenter: parent.horizontalCenter
			verticalCenter: parent.verticalCenter
		}
		horizontalAlignment: Text.AlignHCenter
		font.pixelSize: isNxt ? 85 : 65
		font.family: qfont.regular.name
	}

	Text {
		id: txtTotalEnergyToday
		text: app.totalEnergyToday.toFixed(1) + "kWh";
		color: colors.clockTileColor
		anchors {
			horizontalCenter: parent.horizontalCenter
			baseline: parent.bottom
			baselineOffset: isNxt ? -38 : -30
		}
		horizontalAlignment: Text.AlignHCenter
		font.pixelSize: isNxt ? 21 : 16
		font.family: qfont.regular.name
	}
	
	Text {
		id: txtStatusInverter1
		text: app.statusInverter1Str
		color:{
			if (!dimState) {
				app.statusInverter1 ? colors.clockTileColor : "#cc3300"
			} else {
				app.statusInverter1 ? "#dcdcdc" : "#a8a8a8"
			}
		}
		anchors {
			top: parent.top
			topMargin: isNxt ? 13 : 10
			left: parent.left
			leftMargin: isNxt ? 13 : 10
		}
		horizontalAlignment: Text.AlignHCenter
		font.pixelSize: isNxt ? 17 : 13
		font.family: qfont.regular.name
	}
	
	Text {
		id: txtStatusInverter2
		text: app.statusInverter2Str
		color:{
			if (!dimState) {
				app.statusInverter2 ? colors.clockTileColor : "#cc3300"
			} else {
				app.statusInverter2 ? "#dcdcdc" : "#a8a8a8"
			}
		}
		anchors {
			top: txtStatusInverter1.top
			horizontalCenter: parent.horizontalCenter
		}
		horizontalAlignment: Text.AlignHCenter
		font.pixelSize: isNxt ? 17 : 13
		font.family: qfont.regular.name
	}
	
	Text {
		id: txtStatusInverter3
		text: app.statusInverter3Str
		color:{
			if (!dimState) {
				app.statusInverter3 ? colors.clockTileColor : "#cc3300"
			} else {
				app.statusInverter3 ? "#dcdcdc" : "#a8a8a8"
			}
		}
		anchors {
			top: txtStatusInverter1.top
			right: parent.right
			rightMargin: isNxt ? 13 : 10
		}
		horizontalAlignment: Text.AlignHCenter
		font.pixelSize: isNxt ? 17 : 13
		font.family: qfont.regular.name
	}
	
// Debug info shown on tile
/*	Text {
		id: txtDebug
		text: app.updateInterval + "ms"
		color: colors.clockTileColor
		anchors {
			baseline: parent.bottom
			baselineOffset: isNxt ? -13 : -10
			left: parent.left
			leftMargin: isNxt ? 13 : 10
		}
		horizontalAlignment: Text.AlignHCenter
		font.pixelSize: isNxt ? 20 : 15
		font.family: qfont.regular.name
	}
*/	

	Text {
		id: txtTotalInverterAmp
		text: app.totalInverterAmp.toFixed(1) + "A"
		color: colors.clockTileColor
		anchors {
			baseline: parent.bottom
			baselineOffset: isNxt ? -13 : -10
			right: parent.right
			rightMargin: isNxt ? 13 : 10
		}
		horizontalAlignment: Text.AlignHCenter
		font.pixelSize: isNxt ? 20 : 15
		font.family: qfont.regular.name
	}
}
