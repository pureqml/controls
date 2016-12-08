Text {
	property alias icon: text;
	property alias size: font.pixelSize;
	font.family: "Material Icons";

	constructor: {
		_globals.html5.html.loadExternalStylesheet("https://fonts.googleapis.com/icon?family=Material+Icons")
	}
}