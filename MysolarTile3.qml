import QtQuick 2.1
//import qb.base 1.0
import qb.components 1.0

Tile {
	id: mySolarTile3
//	tileSize: tilesize_2X1

	/// Will be called when widget instantiated
	function init() {}

	onClicked: {
		if (app.mySolarConfig) {
			app.mySolarConfig.show();
		}
	}

	Text {
		id: txtActualPower3
		text: app.actualPower3 + "W"
		color: (typeof dimmableColors !== 'undefined') ? dimmableColors.clockTileColor : colors.clockTileColor
		anchors {
			horizontalCenter: parent.horizontalCenter
			verticalCenter: parent.verticalCenter
		}
		horizontalAlignment: Text.AlignHCenter
		font.pixelSize: isNxt ? 85 : 65
		font.family: qfont.regular.name
	}

	Text {
		id: txtEnergyToday3
		text: app.energyToday3.toFixed(1) + "kWh";
		color: (typeof dimmableColors !== 'undefined') ? dimmableColors.clockTileColor : colors.clockTileColor
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
		id: txtStatusInverter3
		text: app.statusInverter3Str
		color:{
			if (!dimState) {
				app.statusInverter3 ? (typeof dimmableColors !== 'undefined') ? dimmableColors.clockTileColor : colors.clockTileColor : "#cc3300"
			} else {
				app.statusInverter3 ? "#dcdcdc" : "#a8a8a8"
			}
		}
		anchors {
			top: parent.top
			topMargin: isNxt ? 13 : 10
			horizontalCenter: parent.horizontalCenter
		}
		horizontalAlignment: Text.AlignHCenter
		font.pixelSize: isNxt ? 17 : 13
		font.family: qfont.regular.name
	}
	
	Text {
		id: txtInverterTemp3
		text: app.inverterTemp3 + "°C"
		color: (typeof dimmableColors !== 'undefined') ? dimmableColors.clockTileColor : colors.clockTileColor
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
	
	Text {
		id: txtInverterVolts3
		text: app.inverterVolts3 + "V"
		color: (typeof dimmableColors !== 'undefined') ? dimmableColors.clockTileColor : colors.clockTileColor
		anchors {
			top: txtInverterTemp3.top
			horizontalCenter: parent.horizontalCenter
		}
		horizontalAlignment: Text.AlignHCenter
		font.pixelSize: isNxt ? 20 : 15
		font.family: qfont.regular.name
	}
	
	Text {
		id: txtInverterAmp3
		text: app.inverterAmp3.toFixed(1) + "A"
		color: (typeof dimmableColors !== 'undefined') ? dimmableColors.clockTileColor : colors.clockTileColor
		anchors {
			top: txtInverterTemp3.top
			right: parent.right
			rightMargin: isNxt ? 13 : 10
		}
		horizontalAlignment: Text.AlignHCenter
		font.pixelSize: isNxt ? 20 : 15
		font.family: qfont.regular.name
	}
	
}
