Item {
	property string label;
	property string value;
	height: 35;
	anchors.left: parent.left;
	anchors.right: parent.right;

	Text {
		height: parent.height;
		anchors.left: parent.left;
		color: "#80D8FF";
		font.pixelSize: 24;
		text: parent.label;
	}

	Text {
		height: parent.height;
		anchors.left: parent.left;
		anchors.leftMargin: 200;
		color: "#fff";
		font.pixelSize: 24;
		text: parent.value;
	}
}
