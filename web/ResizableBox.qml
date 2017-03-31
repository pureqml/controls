Rectangle {
	id: resizable;
	property int maxWidth;
	property int maxHeight;
	property int minHeight: 1;
	property int minWidth: 1;
	color: "#BBDEFB";
	border.width: 1;
	border.color: "gray";

	Item {
		id: resizer;
		width:0;
		height:0;
		y: parent.height;
		x: parent.width;
		z: 1;
		property Mixin hover: HoverClickMixin { cursor: "se-resize";}
		property Mixin drag: DragMixin {
			bottom: parent.parent.maxHeight;
			top: parent.parent.minHeight;
			right: parent.parent.maxWidth;
			left: parent.parent.minWidth;
		}

		onXChanged: { this.parent.width = value; }
		onYChanged: { this.parent.height = value; }

		Rectangle {
			x: -15; y: -15;
			width: 24; height: 24;
			radius: 12;
			color: "#607D8B";
			opacity: parent.hover.value ? 0.9 : 0.2;
		}
	}
}
