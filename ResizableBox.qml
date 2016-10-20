Rectangle {
	id: resizable;
	width: resizer.x;
	height: resizer.y;
	property int maxWidth;
	property int maxHeight;
	property int minHeight: 1;
	property int minWidth: 1;
	property int defaultWidth: 400;
	property int defaultHeight: 200;
	color: "#BBDEFB";
	border.width: 1;
	border.color: "gray";

	Item {
		id: resizer;
		width:0;
		height:0;
		y: parent.defaultHeight;
		x: parent.defaultWidth;
		property Mixin hover: HoverMixin { cursor: "se-resize";}
		property Mixin drag: DragMixin {
			limity2: parent.parent.maxHeight;
			limity1: parent.parent.minHeight;
			limitx2: parent.parent.maxWidth;
			limitx1: parent.parent.minWidth;
		}

		Rectangle {
			x: -15; y: -15;
			width: 24; height: 24;
			radius: 12; 
			color: "#607D8B";
			opacity: parent.hover.value ? 0.9 : 0.2;
		}
	}
}