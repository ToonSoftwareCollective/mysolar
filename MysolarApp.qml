import QtQuick 1.1
import qb.components 1.0
import qb.base 1.0
import FileIO 1.0

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//					
//					App			: mySolar
//					Version		: 1.0.0
//					Description	: App shows live data from FP4ALL dataloggers for AEG/Chint inverters
//					Author		: Edwin Janssen
//					
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



App {
	id: mysolarApp

	property url tileUrl : "MysolarTile.qml";
	property url tileUrl1 : "MysolarTile1.qml";
	property url tileUrl2 : "MysolarTile2.qml";
	property url tileUrl3 : "MysolarTile3.qml";
	property url thumbnailIcon: "./drawables/fp4all_thumbnail.png";
	property 		MysolarConfig mySolarConfig
	property url mySolarConfigUrl : "MysolarConfig.qml"
	property url trayUrl: "MysolarTray.qml"
	property SystrayIcon mysolarTray
	property int onlineUpdateInterval : 1
	property int offlineUpdateInterval : 60
	property int updateInterval : 5000
	property bool enableSystray : true
	property bool statusInverter1 : false
	property bool statusInverter2 : false
	property bool statusInverter3 : false
	property string statusInverter1Str : ""
	property string statusInverter2Str : ""
	property string statusInverter3Str : ""
	property string 	mySolarName1 : ""
	property string 	mySolarName2 : ""
	property string 	mySolarName3 : ""
	property string 	mySolarIP1 : "0.0.0.0"
	property string 	mySolarIP2 : "0.0.0.0"
	property string 	mySolarIP3 : "0.0.0.0"
	property int 	mySolarWp1 : 0
	property int 	mySolarWp2 : 0
	property int 	mySolarWp3 : 0
	property variant mySolarSettingsJson : {
		'FP4ALLName1': "",
		'FP4ALLIP1': "",
		'FP4ALLWp1': "",
		'FP4ALLName2': "",
		'FP4ALLIP2': "",
		'FP4ALLWp2': "",
		'FP4ALLName3': "",
		'FP4ALLIP3': "",
		'FP4ALLWp3': "",
		'TrayIcon' : "Yes",
		'OnlineUpdate' : "",
		'OfflineUpdate' : "",
	}
	property int actualPower1 : 0
	property int actualPower2 : 0
	property int actualPower3 : 0
	property int totalActualPower : 0
	property real inverterTemp1 : 0
	property real inverterTemp2 : 0
	property real inverterTemp3 : 0
	property real inverterVolts1 : 0
	property real inverterVolts2 : 0
	property real inverterVolts3 : 0
	property real inverterAmp1 : 0
	property real inverterAmp2 : 0
	property real inverterAmp3 : 0
	property real totalInverterAmp : 0
	property real energyToday1 : 0
	property real energyToday2 : 0
	property real energyToday3 : 0
	property real totalEnergyToday : 0
	property real energyTotal1 : 0
	property real energyTotal2 : 0
	property real energyTotal3 : 0
	property real totalEnergyTotal : 0
	property int hoursTotal1 : 0
	property int hoursTotal2 : 0
	property int hoursTotal3 : 0
	property int totalHoursTotal : 0
	property int totalmaxPower : 0
	property variant mySolarStatus1Json : {
		'FP4ALLName1': "",
		'FP4ALLIP1': "",
		'FP4ALLWp1': "",
		'inverter_online': false,
		'gauge_power': "",
		'gauge_temp': "",
		'gauge_vpv': "",
		'gauge_iac': "",
		'energy_today': "",
		'energy_total': "",
		'hours_total': "",
	}
	property variant mySolarStatus2Json : {
		'FP4ALLName2': "",
		'FP4ALLIP2': "",
		'FP4ALLWp2': "",
		'inverter_online': false,
		'gauge_power': "",
		'gauge_temp': "",
		'gauge_vpv': "",
		'gauge_iac': "",
		'energy_today': "",
		'energy_total': "",
		'hours_total': "",
	}
	property variant mySolarStatus3Json : {
		'FP4ALLName3': "",
		'FP4ALLIP3': "",
		'FP4ALLWp3': "",
		'inverter_online': false,
		'gauge_power': "",
		'gauge_temp': "",
		'gauge_vpv': "",
		'gauge_iac': "",
		'energy_today': "",
		'energy_total': "",
		'hours_total': "",
	}
	
	function init() {
		registry.registerWidget("tile", tileUrl, this, null, {thumbLabel: qsTr("FP4All All"), thumbIcon: thumbnailIcon, thumbCategory: "general", thumbWeight: 30, baseTileWeight: 10, baseTileSolarWeight: 10, thumbIconVAlignment: "center"});
		registry.registerWidget("tile", tileUrl1, this, null, {thumbLabel: qsTr("FP4All 1."), thumbIcon: thumbnailIcon, thumbCategory: "general", thumbWeight: 30, baseTileWeight: 10, baseTileSolarWeight: 10, thumbIconVAlignment: "center"});
		registry.registerWidget("tile", tileUrl2, this, null, {thumbLabel: qsTr("FP4All 2."), thumbIcon: thumbnailIcon, thumbCategory: "general", thumbWeight: 30, baseTileWeight: 10, baseTileSolarWeight: 10, thumbIconVAlignment: "center"});
		registry.registerWidget("tile", tileUrl3, this, null, {thumbLabel: qsTr("FP4All 3."), thumbIcon: thumbnailIcon, thumbCategory: "general", thumbWeight: 30, baseTileWeight: 10, baseTileSolarWeight: 10, thumbIconVAlignment: "center"});
		registry.registerWidget("screen", mySolarConfigUrl, this, "mySolarConfig");
		registry.registerWidget("systrayIcon", trayUrl, mysolarApp);
	}
	
	Component.onCompleted: {
		readDefaults();
		updateSolarTiles();
	}
	
	FileIO {
		id: userSettingsFile
		source: "file:///HCBv2/qml/apps/mysolar/userSettings.json"
	}
	
	FileIO {
		id: latestStatus1File
		source: "file:///HCBv2/qml/apps/mysolar/mySolarStatus1.json"
	}
	
	FileIO {
		id: latestStatus2File
		source: "file:///HCBv2/qml/apps/mysolar/mySolarStatus2.json"
	}
	
	FileIO {
		id: latestStatus3File
		source: "file:///HCBv2/qml/apps/mysolar/mySolarStatus3.json"
	}
	
	function savemySolarSettingsJson() {
	// Save userSettings
		var strSystray = "";
		if (enableSystray) {
			strSystray = "Yes";
		} 
		else {
			strSystray = "No";
  		}
		var mySolarSettingsJson = {
			"FP4ALLName1" : mySolarName1,
			"FP4ALLIP1" : mySolarIP1,
			"FP4ALLWp1" : mySolarWp1,
			"FP4ALLName2" : mySolarName2,
			"FP4ALLIP2" : mySolarIP2,
			"FP4ALLWp2" : mySolarWp2,
			"FP4ALLName3" : mySolarName3,
			"FP4ALLIP3" : mySolarIP3,
			"FP4ALLWp3" : mySolarWp3,
			"TrayIcon" : strSystray,
			"OnlineUpdate" : onlineUpdateInterval,
			"OfflineUpdate" : offlineUpdateInterval};

   		var doc2 = new XMLHttpRequest();
		doc2.open("PUT", "file:///HCBv2/qml/apps/mysolar/userSettings.json");
   		doc2.send(JSON.stringify(mySolarSettingsJson));
	}
	
	// Save SolarStatus1
	function savemySolarStatus1Json() {
		var mySolarStatus1Json = {
			"FP4ALLName1" : mySolarName1,
			"FP4ALLIP1" : mySolarIP1,
			"FP4ALLWp1" : mySolarWp1,
			"inverter_online": statusInverter1,
			"gauge_power" : actualPower1,
			"gauge_temp" : inverterTemp1,
			"gauge_vpv" : inverterVolts1,
			"gauge_iac" : inverterAmp1,
			"energy_today" : energyToday1,
			"energy_total" : energyTotal1,
			"hours_total" : hoursTotal1};

   		var doc2 = new XMLHttpRequest();
		doc2.open("PUT", "file:///HCBv2/qml/apps/mysolar/mySolarStatus1.json");
   		doc2.send(JSON.stringify(mySolarStatus1Json));
	}
	
	// Save SolarStatus2
	function savemySolarStatus2Json() {
		var mySolarStatus2Json = {
			"FP4ALLName2" : mySolarName2,
			"FP4ALLIP2" : mySolarIP2,
			"FP4ALLWp2" : mySolarWp2,
			"inverter_online": statusInverter2,
			"gauge_power" : actualPower2,
			"gauge_temp" : inverterTemp2,
			"gauge_vpv" : inverterVolts2,
			"gauge_iac" : inverterAmp2,
			"energy_today" : energyToday2,
			"energy_total" : energyTotal2,
			"hours_total" : hoursTotal2};

   		var doc2 = new XMLHttpRequest();
		doc2.open("PUT", "file:///HCBv2/qml/apps/mysolar/mySolarStatus2.json");
   		doc2.send(JSON.stringify(mySolarStatus2Json));
	}

	// Save SolarStatus3	
	function savemySolarStatus3Json() {
		var mySolarStatus3Json = {
			"FP4ALLName3" : mySolarName3,
			"FP4ALLIP3" : mySolarIP3,
			"FP4ALLWp3" : mySolarWp3,
			"inverter_online": statusInverter3,
			"gauge_power" : actualPower3,
			"gauge_temp" : inverterTemp3,
			"gauge_vpv" : inverterVolts3,
			"gauge_iac" : inverterAmp3,
			"energy_today" : energyToday3,
			"energy_total" : energyTotal3,
			"hours_total" : hoursTotal3};

   		var doc2 = new XMLHttpRequest();
		doc2.open("PUT", "file:///HCBv2/qml/apps/mysolar/mySolarStatus3.json");
   		doc2.send(JSON.stringify(mySolarStatus3Json));
	}
	
	// Read userSettings
	function readDefaults() {
		mySolarSettingsJson = JSON.parse(userSettingsFile.read());
		mySolarName1 = mySolarSettingsJson ['FP4ALLName1'];
		mySolarIP1 = mySolarSettingsJson ['FP4ALLIP1'];
		mySolarWp1 = mySolarSettingsJson ['FP4ALLWp1'];
		mySolarName2 = mySolarSettingsJson ['FP4ALLName2'];
		mySolarIP2 = mySolarSettingsJson ['FP4ALLIP2'];
		mySolarWp2 = mySolarSettingsJson ['FP4ALLWp2'];
		mySolarName3 = mySolarSettingsJson ['FP4ALLName3'];
		mySolarIP3 = mySolarSettingsJson ['FP4ALLIP3'];
		mySolarWp3 = mySolarSettingsJson ['FP4ALLWp3'];
		onlineUpdateInterval = mySolarSettingsJson ['OnlineUpdate'];
		offlineUpdateInterval = mySolarSettingsJson ['OfflineUpdate'];
		enableSystray = (mySolarSettingsJson ['TrayIcon'] == "Yes");

		if (enableSystray) {
			mysolarTray.show();
		} else {
			mysolarTray.hide();
  		}
	}
	
	// Read SolarStatus1
	function readmySolarStatus1Json() {
		mySolarStatus1Json = JSON.parse(latestStatus1File.read());
		energyToday1 = mySolarStatus1Json ['energy_today'];
		energyTotal1 = mySolarStatus1Json ['energy_total'];
		hoursTotal1 = mySolarStatus1Json ['hours_total'];
	}
	
	// Read SolarStatus2
	function readmySolarStatus2Json() {
		mySolarStatus2Json = JSON.parse(latestStatus2File.read());
		energyToday2 = mySolarStatus2Json ['energy_today'];
		energyTotal2 = mySolarStatus2Json ['energy_total'];
		hoursTotal2 = mySolarStatus2Json ['hours_total'];
	}
	
	// Read SolarStatus3
	function readmySolarStatus3Json() {
		mySolarStatus3Json = JSON.parse(latestStatus3File.read());
		energyToday3 = mySolarStatus3Json ['energy_today'];
		energyTotal3 = mySolarStatus3Json ['energy_total'];
		hoursTotal3 = mySolarStatus3Json ['hours_total'];
	}
	
	function updateSolarTiles() {
		// Readout Solar Inverter 1 status.xml
		if ((mySolarIP1 !== "0.0.0.0") && (mySolarIP1 !== "")) {
			var i = 0;
			var j = 0;
			var xmlhttp1 = new XMLHttpRequest();
			xmlhttp1.onreadystatechange=function() {
				if (xmlhttp1.readyState == 4) {
					if (xmlhttp1.status == 200) {
						statusInverter1 = true
						var aNode1 = xmlhttp1.responseText;
						// Actual Power
						i = aNode1.indexOf("<gauge_power>");
						j = aNode1.indexOf("<", i+13);
						actualPower1 = aNode1.substring(i+13, j);
						// Inverter Temperature
						i = aNode1.indexOf("<gauge_temp>");
						j = aNode1.indexOf("<", i+12);
						inverterTemp1 = aNode1.substring(i+12, j);
						// Inverter DC Voltage
						i = aNode1.indexOf("<gauge_vpv>");
						j = aNode1.indexOf("<", i+11);
						inverterVolts1 = aNode1.substring(i+11, j);
						// Inverter AC Amps
						i = aNode1.indexOf("<gauge_iac>");
						j = aNode1.indexOf("<", i+11);
						inverterAmp1 = aNode1.substring(i+11, j);
						// Energy Today
						i = aNode1.indexOf("<energy_today>");
						j = aNode1.indexOf("<", i+14);
						energyToday1 = aNode1.substring(i+14, j);
						// Energy Total
						i = aNode1.indexOf("<energy_total>");
						j = aNode1.indexOf("<", i+14);
						energyTotal1 = aNode1.substring(i+14, j);
						// Inverter Hours Total
						i = aNode1.indexOf("<hours_total>");
						j = aNode1.indexOf("<", i+13);
						hoursTotal1 = aNode1.substring(i+13, j);
						// Save latest live data
						savemySolarStatus1Json();
					}
					else {
						// Reset Live data values if no connection
						statusInverter1 = false
						actualPower1 = 0
						inverterTemp1 = 0
						inverterVolts1 = 0
						inverterAmp1 = 0
						savemySolarStatus1Json();
						// Read last known daily data if no connection
						readmySolarStatus1Json();
					}
				}
			}
			xmlhttp1.open("GET", "http://" + mySolarIP1 + "/status.xml", true);
			xmlhttp1.timeout = 500;
			xmlhttp1.send();
		}
			
		// Readout Solar Inverter 2 status.xml
		if ((mySolarIP2 !== "0.0.0.0") && (mySolarIP2 !== "")) {
			var i = 0;
			var j = 0;
			var xmlhttp2 = new XMLHttpRequest();
			xmlhttp2.onreadystatechange=function() {
				if (xmlhttp2.readyState == 4) {
					if (xmlhttp2.status == 200) {
						statusInverter2 = true
						var aNode2 = xmlhttp2.responseText;
						// Actual Power
						i = aNode2.indexOf("<gauge_power>");
						j = aNode2.indexOf("<", i+13);
						actualPower2 = aNode2.substring(i+13, j);
						// Inverter Temperature
						i = aNode2.indexOf("<gauge_temp>");
						j = aNode2.indexOf("<", i+12);
						inverterTemp2 = aNode2.substring(i+12, j);
						// Inverter DC Voltage
						i = aNode2.indexOf("<gauge_vpv>");
						j = aNode2.indexOf("<", i+11);
						inverterVolts2 = aNode2.substring(i+11, j);
						// Inverter AC Amps
						i = aNode2.indexOf("<gauge_iac>");
						j = aNode2.indexOf("<", i+11);
						inverterAmp2 = aNode2.substring(i+11, j);
						// Energy Today
						i = aNode2.indexOf("<energy_today>");
						j = aNode2.indexOf("<", i+14);
						energyToday2 = aNode2.substring(i+14, j);
						// Energy Total
						i = aNode2.indexOf("<energy_total>");
						j = aNode2.indexOf("<", i+14);
						energyTotal2 = aNode2.substring(i+14, j);
						// Inverter Hours Total
						i = aNode2.indexOf("<hours_total>");
						j = aNode2.indexOf("<", i+13);
						hoursTotal2 = aNode2.substring(i+13, j);
						// Save latest live data
						savemySolarStatus2Json();
					}
					else {
						// Reset Live data values if no connection
						statusInverter2 = false
						actualPower2 = 0
						inverterTemp2 = 0
						inverterVolts2 = 0
						inverterAmp2 = 0
						savemySolarStatus2Json();
						// Read last known daily data if no connection
						readmySolarStatus2Json();
					}
				}
			}
			xmlhttp2.open("GET", "http://" + mySolarIP2 + "/status.xml", true);
			xmlhttp2.timeout = 500;
			xmlhttp2.send();
		}
		
		// Readout Solar Inverter 3 status.xml
		if ((mySolarIP3 !== "0.0.0.0") && (mySolarIP3 !== "")) {
			var i = 0;
			var j = 0;
			var xmlhttp3 = new XMLHttpRequest();
			xmlhttp3.onreadystatechange=function() {
				if (xmlhttp3.readyState == 4) {
					if (xmlhttp3.status == 200) {
						statusInverter3 = true
						var aNode3 = xmlhttp3.responseText;
						// Actual Power
						i = aNode3.indexOf("<gauge_power>");
						j = aNode3.indexOf("<", i+13);
						actualPower3 = aNode3.substring(i+13, j);
						// Inverter Temperature
						i = aNode3.indexOf("<gauge_temp>");
						j = aNode3.indexOf("<", i+12);
						inverterTemp3 = aNode3.substring(i+12, j);
						// Inverter DC Voltage
						i = aNode3.indexOf("<gauge_vpv>");
						j = aNode3.indexOf("<", i+11);
						inverterVolts3 = aNode3.substring(i+11, j);
						// Inverter AC Amps
						i = aNode3.indexOf("<gauge_iac>");
						j = aNode3.indexOf("<", i+11);
						inverterAmp3 = aNode3.substring(i+11, j);
						// Energy Today
						i = aNode3.indexOf("<energy_today>");
						j = aNode3.indexOf("<", i+14);
						energyToday3 = aNode3.substring(i+14, j);
						// Energy Total
						i = aNode3.indexOf("<energy_total>");
						j = aNode3.indexOf("<", i+14);
						energyTotal3 = aNode3.substring(i+14, j);
						// Inverter Hours Total
						i = aNode3.indexOf("<hours_total>");
						j = aNode3.indexOf("<", i+13);
						hoursTotal3 = aNode3.substring(i+13, j);
						// Save latest live data
						savemySolarStatus3Json();
					}
					else {
						// Reset Live data values if no connection
						statusInverter3 = false
						actualPower3 = 0
						inverterTemp3 = 0
						inverterVolts3 = 0
						inverterAmp3 = 0
						savemySolarStatus3Json();
						// Read last known daily data if no connection
						readmySolarStatus3Json();
					}
				}
			}
			xmlhttp3.open("GET", "http://" + mySolarIP3 + "/status.xml", true);
			xmlhttp3.timeout = 500;
			xmlhttp3.send();
		}

		// Inverter Status
		if (statusInverter1) {
			statusInverter1Str = "1:On"
		} else {
			statusInverter1Str = "1:Off"
		}
		if (statusInverter2) {
			statusInverter2Str = "2:On"
		} else {
			statusInverter2Str = "2:Off"
		}
		if (statusInverter3) {
			statusInverter3Str = "3:On"
		} else {
			statusInverter3Str = "3:Off"
		}
		
		// Set Timer update Interval based on status
		if ((statusInverter1) || (statusInverter2) || (statusInverter3)) {
			updateInterval = (onlineUpdateInterval * 1000) 
		} else {
			updateInterval = (offlineUpdateInterval * 1000) 
		}
		
		// Actual Power
		totalActualPower = actualPower1 + actualPower2 + actualPower3;
		// Inverter Temperature
		
		// Inverter DC Voltage
		
		// Inverter AC Amps
		totalInverterAmp = inverterAmp1 + inverterAmp2 + inverterAmp3;
		// Energy Today
		totalEnergyToday = energyToday1 + energyToday2 + energyToday3;
		// Energy Total
		totalEnergyTotal = energyTotal1 + energyTotal2 + energyTotal3
		// Inverter Hours Total
		totalHoursTotal = hoursTotal1 + hoursTotal2 + hoursTotal3;
		// Max Power
		totalMaxPower = mySolarWp1 + mySolarWp2 + mySolarWp3;
	}
	
	function resetForNewDay() {
		var now = new Date();
		if ((now.getHours() == "00") && (now.getMinutes() == "00")){
			energyToday1 = 0
			energyToday2 = 0
			energyToday3 = 0
			savemySolarStatus1Json();
			savemySolarStatus2Json();
			savemySolarStatus3Json();
		}
	}

	Timer {
		id: updateSolarTimer
		interval: updateInterval
		triggeredOnStart: true
		running: true
		repeat: true
		onTriggered: updateSolarTiles()
	}
	
	Timer {
		id: resetTimer
		interval: 1000
		triggeredOnStart: true
		running: true
		repeat: true
		onTriggered: resetForNewDay()
	}
}
