import QtQuick 2.1
//import qb.base 1.0
import qb.components 1.0

Tile {
	id: mySolarTile1
//	tileSize: tilesize_2X1

	/// Will be called when widget instantiated
	function init() {}

	onClicked: {
		if (app.mySolarConfig) {
			app.mySolarConfig.show();
		}
	}

	Text {
		id: txtActualPower1
		text: app.actualPower1 + "W"
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
		id: txtEnergyToday1
		text: app.energyToday1.toFixed(1) + "kWh";
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
		id: txtStatusInverter1
		text: app.statusInverter1Str
		color:{
			if (!dimState) {
				app.statusInverter1 ? (typeof dimmableColors !== 'undefined') ? dimmableColors.clockTileColor : colors.clockTileColor : "#cc3300"
			} else {
				app.statusInverter1 ? "#dcdcdc" : "#a8a8a8"
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
		id: txtInverterTemp1
		text: app.inverterTemp1 + "°C"
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
		id: txtInverterVolts1
		text: app.inverterVolts1 + "V"
		color: (typeof dimmableColors !== 'undefined') ? dimmableColors.clockTileColor : colors.clockTileColor
		anchors {
			top: txtInverterTemp1.top
			horizontalCenter: parent.horizontalCenter
		}
		horizontalAlignment: Text.AlignHCenter
		font.pixelSize: isNxt ? 20 : 15
		font.family: qfont.regular.name
	}
	
	Text {
		id: txtInverterAmp1
		text: app.inverterAmp1.toFixed(1) + "A"
		color: (typeof dimmableColors !== 'undefined') ? dimmableColors.clockTileColor : colors.clockTileColor
		anchors {
			top: txtInverterTemp1.top
			right: parent.right
			rightMargin: isNxt ? 13 : 10
		}
		horizontalAlignment: Text.AlignHCenter
		font.pixelSize: isNxt ? 20 : 15
		font.family: qfont.regular.name
	}
	
}
