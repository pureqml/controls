Rectangle {
	id: key;
	height: 45;
	width: model.widthScale ? model.widthScale * (height + 5) - 5 : height;
	color: model.contextColor ? model.contextColor : "#444";
	border.color: "#fff";
	border.width: activeFocus && parent.activeFocus ? 5 : 0;

	Text {
		id: keyText;
		anchors.centerIn: parent;
		text: model.text;
		color: "#fff";
	}

	Image {
		anchors.centerIn: parent;
		source: model.icon;
		visible: model.icon;
	}
}
