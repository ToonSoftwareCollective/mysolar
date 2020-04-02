import QtQuick 2.1
//import qb.base 1.0
import qb.components 1.0

Tile {
	id: mySolarTile2
//	tileSize: tilesize_2X1

	/// Will be called when widget instantiated
	function init() {}

	onClicked: {
		if (app.mySolarConfig) {
			app.mySolarConfig.show();
		}
	}

	Text {
		id: txtActualPower2
		text: app.actualPower2 + "W"
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
		id: txtEnergyToday2
		text: app.energyToday2.toFixed(1) + "kWh";
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
		id: txtStatusInverter2
		text: app.statusInverter2Str
		color:{
			if (!dimState) {
				app.statusInverter2 ? (typeof dimmableColors !== 'undefined') ? dimmableColors.clockTileColor : colors.clockTileColor : "#cc3300"
			} else {
				app.statusInverter2 ? "#dcdcdc" : "#a8a8a8"
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
		id: txtInverterTemp2
		text: app.inverterTemp2 + "°C"
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
		id: txtInverterVolts2
		text: app.inverterVolts2 + "V"
		color: (typeof dimmableColors !== 'undefined') ? dimmableColors.clockTileColor : colors.clockTileColor
		anchors {
			top: txtInverterTemp2.top
			horizontalCenter: parent.horizontalCenter
		}
		horizontalAlignment: Text.AlignHCenter
		font.pixelSize: isNxt ? 20 : 15
		font.family: qfont.regular.name
	}
	
	Text {
		id: txtInverterAmp2
		text: app.inverterAmp2.toFixed(1) + "A"
		color: (typeof dimmableColors !== 'undefined') ? dimmableColors.clockTileColor : colors.clockTileColor
		anchors {
			top: txtInverterTemp2.top
			right: parent.right
			rightMargin: isNxt ? 13 : 10
		}
		horizontalAlignment: Text.AlignHCenter
		font.pixelSize: isNxt ? 20 : 15
		font.family: qfont.regular.name
	}
	
}
