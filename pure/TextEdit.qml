Rectangle {
	id: textEditProto;
	property Paddings paddings: Paddings {}
	property string placeholder;
	property alias horizontalAlignment: innerText.horizontalAlignment;
	property alias backgroundColor: color;
	property alias text: innerText.text;
	property alias font: innerText.font;
	property alias color: innerText.color;
	property bool cursorVisible: true;
	focus: true;
	clip: true;

	function _update(name, value) {
		switch (name) {
			case 'placeholder': this.element.setAttribute('placeholder', value); break
		}

		_globals.core.Rectangle.prototype._update.apply(this, arguments);
	}

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
}
