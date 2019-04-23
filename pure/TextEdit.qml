Rectangle {
	id: textEditProto;
	property lazy paddings: Paddings {}
	property string placeholder;
	property alias horizontalAlignment: innerText.horizontalAlignment;
	property alias backgroundColor: color;
	property alias text: innerText.text;
	property alias font: innerText.font;
	property alias color: innerText.color;
	property bool cursorVisible: true;
	focus: true;
	clip: true;

	Rectangle {
		id: cursor;
		x: innerText.paintedWidth;
		width: 2;
		height: innerText.paintedHeight;
		anchors.verticalCenter: parent.verticalCenter;
		color: innerText.color;
		visible: parent.activeFocus && textEditProto.cursorVisible;
	}

	Text {
		id: innerText;
		anchors.verticalCenter: parent.verticalCenter;
	}

	Timer {
		running: parent.activeFocus && textEditProto.cursorVisible;
		repeat: true;
		interval: 1000;

		onTriggered: { cursor.visible = !cursor.visible; }
	}

	removeChar: {
		var text = textEditProto.text
		textEditProto.text = text.slice(0, text.length - 1)
	}

	onPlaceholderChanged: { this.element.setAttribute('placeholder', value); }
}
