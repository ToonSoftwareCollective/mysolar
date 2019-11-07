import QtQuick 2.1
import qb.components 1.0

Screen {
	id: mySolarConfig
	
	screenTitle: "mySolar Settings";
	
	function savemySolarName1(text) {
		if (text) {
			app.mySolarName1 = text;
			mySolarName1Label.inputText = app.mySolarName1;
		}
	}
	
	function savemySolarName2(text) {
		if (text) {
			app.mySolarName2 = text;
			mySolarName2Label.inputText = app.mySolarName2;
		}
	}
	
	function savemySolarName3(text) {
		if (text) {
			app.mySolarName3 = text;
			mySolarName3Label.inputText = app.mySolarName3;
		}
	}
	
	function savemySolarIP1(text) {
		if (text) {
			app.mySolarIP1 = text;
			mySolarIP1Label.inputText = app.mySolarIP1;
		}
	}
	
	function savemySolarIP2(text) {
		if (text) {
			app.mySolarIP2 = text;
			mySolarIP2Label.inputText = app.mySolarIP2;
		}
	}
	
	function savemySolarIP3(text) {
		if (text) {
			app.mySolarIP3 = text;
			mySolarIP3Label.inputText = app.mySolarIP3;
		}
	}
	
	function savemySolarWp1(text) {
		if (text) {
			app.mySolarWp1 = text;
			mySolarWp1Label.inputText = app.mySolarWp1;
		}
	}
	
	function savemySolarWp2(text) {
		if (text) {
			app.mySolarWp2 = text;
			mySolarWp2Label.inputText = app.mySolarWp2;
		}
	}
	
	function savemySolarWp3(text) {
		if (text) {
			app.mySolarWp3 = text;
			mySolarWp3Label.inputText = app.mySolarWp3;
		}
	}
	
	function saveonlineUpdateInterval(text) {
		if (text) {
			app.onlineUpdateInterval = text;
			myOnlineUpdateIntervalLabel.inputText = app.onlineUpdateInterval;
		}
	}
	
	function saveofflineUpdateInterval(text) {
		if (text) {
			app.offlineUpdateInterval = text;
			myOfflineUpdateIntervalLabel.inputText = app.offlineUpdateInterval;
		}
	}
	
	function validateWp(text, isFinalString) {
		if (isFinalString) {
			if (text == null) 
				return {title: "Invalid Input", content: "Enter a number, if unused enter 0"};
			else
				return null;
		}
		return null;
	}
	
	function validateInterval(text, isFinalString) {
		if (isFinalString) {
			if (parseInt(text) < 1) 
				return {title: "Invalid Input", content: "Enter a number higher than 0"};
			else
				return null;
		}
		return null;
	}

	onShown: {
		addCustomTopRightButton("Save Settings");
		mySolarName1Label.inputText = app.mySolarName1;
		mySolarName2Label.inputText = app.mySolarName2;
		mySolarName3Label.inputText = app.mySolarName3;
		mySolarIP1Label.inputText = app.mySolarIP1;
		mySolarIP2Label.inputText = app.mySolarIP2;
		mySolarIP3Label.inputText = app.mySolarIP3;
		mySolarWp1Label.inputText = app.mySolarWp1;
		mySolarWp2Label.inputText = app.mySolarWp2;
		mySolarWp3Label.inputText = app.mySolarWp3;
		myOnlineUpdateIntervalLabel.inputText = app.onlineUpdateInterval;
		myOfflineUpdateIntervalLabel.inputText = app.offlineUpdateInterval;
		enableSystrayToggle.isSwitchedOn = app.enableSystray;
	}
	
	onCustomButtonClicked: {
		hide();
		app.savemySolarSettingsJson();
		if ((app.mySolarIP1 == "0.0.0.0") || (app.mySolarIP1 == "")) {
			// Clear all data values if no IP set
				app.statusInverter1 = false
				app.actualPower1 = 0
				app.inverterTemp1 = 0
				app.inverterVolts1 = 0
				app.inverterAmp1 = 0
				app.energyToday1 = 0
				app.energyTotal1 = 0
				app.hoursTotal1 = 0
				app.savemySolarStatus1Json();
		}
		if ((app.mySolarIP2 == "0.0.0.0") || (app.mySolarIP2 == "")) {
			// Clear all data values if no IP set
				app.statusInverter2 = false
				app.actualPower2 = 0
				app.inverterTemp2 = 0
				app.inverterVolts2 = 0
				app.inverterAmp2 = 0
				app.energyToday2 = 0
				app.energyTotal2 = 0
				app.hoursTotal2 = 0
				app.savemySolarStatus2Json();
		}
		if ((app.mySolarIP3 == "0.0.0.0") || (app.mySolarIP3 == "")) {
			// Clear all data values if no IP set
				app.statusInverter3 = false
				app.actualPower3 = 0
				app.inverterTemp3 = 0
				app.inverterVolts3 = 0
				app.inverterAmp3 = 0
				app.energyToday3 = 0
				app.energyTotal3 = 0
				app.hoursTotal3 = 0
				app.savemySolarStatus3Json();
		}
		app.updateSolarTiles();
	}
	
	Text {
		id: myLabel1
		text: "Example: Logger1"
		font.pixelSize: isNxt ? 22 : 18
		anchors {
			left: parent.left
			top: parent.top
			leftMargin: 20
			topMargin: 20
		}
	}

	Text {
		id: myLabel2
		text: "Example: 192.168.1.2"
		font.pixelSize: isNxt ? 22 : 18
		anchors {
			left: myLabel1.right
			top: myLabel1.top
			leftMargin: isNxt ? 200 : 160
		}
	}
	
	Text {
		id: myLabel3
		text: "Example: 2760"
		font.pixelSize: isNxt ? 22 : 18
		anchors {
			left: myLabel2.right
			top: myLabel1.top
			leftMargin: isNxt ? 125 : 100
		}
	}
	
	EditTextLabel {
		id: mySolarName1Label
		width: isNxt ? 313 : 250
		height: isNxt ? 50 : 40
		leftTextAvailableWidth: isNxt ? 125 : 100
		leftText: "1. Name"

		anchors {
			left: myLabel1.left
			top: myLabel1.bottom
			topMargin: isNxt ? 15 : 12
		}

		onClicked: {
			qkeyboard.open("Name", mySolarName1Label.inputText, savemySolarName1);
		}
	}
	
	EditTextLabel {
		id: mySolarIP1Label
		width: isNxt ? 250 : 200
		height: isNxt ? 50 : 40
		leftTextAvailableWidth: isNxt ? 63 : 50
		leftText: "IP"

		anchors {
			left: myLabel2.left
			top: mySolarName1Label.top
			rightMargin: 20
			bottomMargin: 20
		}

		onClicked: {
			qkeyboard.open("IP", mySolarIP1Label.inputText, savemySolarIP1);
		}
	}
	
	EditTextLabel {
		id: mySolarWp1Label
		width: isNxt ? 188 : 150
		height: isNxt ? 50 : 40
		leftTextAvailableWidth: isNxt ? 63 : 50
		leftText: "Wp"

		anchors {
			left: myLabel3.left
			top: mySolarName1Label.top
			rightMargin: 20
			bottomMargin: 20
		}

		onClicked: {
			qnumKeyboard.open("Wp", mySolarWp1Label.inputText, app.mySolarWp1, 1 ,savemySolarWp1, validateWp);
			qnumKeyboard.maxTextLength = 5;
			qnumKeyboard.state = "num_integer_clear_backspace";
		}
	}
	
	EditTextLabel {
		id: mySolarName2Label
		width: isNxt ? 313 : 250
		height: isNxt ? 50 : 40
		leftTextAvailableWidth: isNxt ? 125: 100
		leftText: "2. Name"

		anchors {
			left: mySolarName1Label.left
			top: mySolarName1Label.bottom
			topMargin: isNxt ? 15 : 12
		}

		onClicked: {
			qkeyboard.open("Name", mySolarName2Label.inputText, savemySolarName2);
		}
	}

	EditTextLabel {
		id: mySolarIP2Label
		width: isNxt ? 250 : 200
		height: isNxt ? 50 : 40
		leftTextAvailableWidth: isNxt ? 63 : 50
		leftText: "IP"

		anchors {
			left: myLabel2.left
			top: mySolarName2Label.top
			rightMargin: 20
			bottomMargin: 20
		}

		onClicked: {
			qkeyboard.open("IP", mySolarIP2Label.inputText, savemySolarIP2);
		}
	}
	
	EditTextLabel {
		id: mySolarWp2Label
		width: isNxt ? 188 : 150
		height: isNxt ? 50 : 40
		leftTextAvailableWidth: isNxt ? 63 : 50
		leftText: "Wp"

		anchors {
			left: myLabel3.left
			top: mySolarName2Label.top
			rightMargin: 20
			bottomMargin: 20
		}

		onClicked: {
			qnumKeyboard.open("Wp", mySolarWp2Label.inputText, app.mySolarWp2, 1 ,savemySolarWp2, validateWp);
			qnumKeyboard.maxTextLength = 5;
			qnumKeyboard.state = "num_integer_clear_backspace";
		}
	}
	
	EditTextLabel {
		id: mySolarName3Label
		width: isNxt ? 313 : 250
		height: isNxt ? 50 : 40
		leftTextAvailableWidth: isNxt ? 125 : 100
		leftText: "3. Name"

		anchors {
			left: mySolarName2Label.left
			top: mySolarName2Label.bottom
			topMargin: isNxt ? 15 : 12
		}

		onClicked: {
			qkeyboard.open("Name", mySolarName3Label.inputText, savemySolarName3);
		}
	}
	
	EditTextLabel {
		id: mySolarIP3Label
		width: isNxt ? 250 : 200
		height: isNxt ? 50 : 40
		leftTextAvailableWidth: isNxt ? 63 : 50
		leftText: "IP"

		anchors {
			left: myLabel2.left
			top: mySolarName3Label.top
			rightMargin: 20
			bottomMargin: 20
		}

		onClicked: {
			qkeyboard.open("IP", mySolarIP3Label.inputText, savemySolarIP3);
		}
	}
	
	EditTextLabel {
		id: mySolarWp3Label
		width: isNxt ? 188 : 150
		height: isNxt ? 50 : 40
		leftTextAvailableWidth: isNxt ? 63 : 50
		leftText: "Wp"

		anchors {
			left: myLabel3.left
			top: mySolarName3Label.top
			rightMargin: 20
			bottomMargin: 20
		}

		onClicked: {
			qnumKeyboard.open("Wp", mySolarWp3Label.inputText, app.mySolarWp3, 1 ,savemySolarWp3, validateWp);
			qnumKeyboard.maxTextLength = 5;
			qnumKeyboard.state = "num_integer_clear_backspace";
		}
	}
	EditTextLabel {
		id: myOnlineUpdateIntervalLabel
		width: isNxt ? 400 : 320
		height: isNxt ? 50 : 40
		leftTextAvailableWidth: isNxt ? 300 : 240
		leftText: "Online update interval (s)"

		anchors {
			left: parent.left
			top: mySolarWp3Label.bottom
			leftMargin: 20
			topMargin: isNxt ? 20 : 16
		}

		onClicked: {
			qnumKeyboard.open("Wp", myOnlineUpdateIntervalLabel.inputText, app.onlineUpdateInterval, 1 ,saveonlineUpdateInterval, validateInterval);
			qnumKeyboard.maxTextLength = 5;
			qnumKeyboard.state = "num_integer_clear_backspace";
		}
	}
	
	EditTextLabel {
		id: myOfflineUpdateIntervalLabel
		width: myOnlineUpdateIntervalLabel.width
		height: isNxt ? 50 : 40
		leftTextAvailableWidth: myOnlineUpdateIntervalLabel.leftTextAvailableWidth
		leftText: "Offline update interval (s)"

		anchors {
			right: mySolarWp3Label.right
			top: myOnlineUpdateIntervalLabel.top
		}

		onClicked: {
			qnumKeyboard.open("Wp", myOfflineUpdateIntervalLabel.inputText, app.offlineUpdateInterval, 1 ,saveofflineUpdateInterval, validateInterval);
			qnumKeyboard.maxTextLength = 5;
			qnumKeyboard.state = "num_integer_clear_backspace";
		}
	}
	
	Text {
		id: enableSystrayLabel
		text: "Systray Icon?"
		anchors {
			left: parent.left
			top: myOnlineUpdateIntervalLabel.bottom
			leftMargin: 20
			topMargin: isNxt ? 50 : 40
		}
	}

	OnOffToggle {
		id: enableSystrayToggle
		height: isNxt ? 50 : 40
		anchors.left: enableSystrayLabel.right
		anchors.leftMargin: 10
		anchors.top: enableSystrayLabel.top
		leftIsSwitchedOn: false
		onSelectedChangedByUser: {
			if (isSwitchedOn) {
				app.enableSystray = true
			} else {
				app.enableSystray = false
			}
		}
	}
}
