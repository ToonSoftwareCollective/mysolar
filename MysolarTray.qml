import QtQuick 1.1
import qb.components 1.0
import qb.base 1.0

SystrayIcon {
	id: mySolarSystrayIcon
	property string objectName: "mysolarTray"

	visible: app.enableSystray
	posIndex: 8000

	onClicked: {
		stage.openFullscreen(app.mySolarConfigUrl);
	}

	Image {
		id: imgmySolar
		anchors.centerIn: parent
		source: "./drawables/fp4all.png"
	}

}
