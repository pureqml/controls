Rectangle {
	property Mixin hoverMixin: HoverMixin {}
	property alias hover: hoverMixin.value;
	property alias clickable: hoverMixin.clickable;
	property alias hoverable: hoverMixin.enabled;
	property alias cursor: hoverMixin.cursor;
	color: "transparent";
	hoverMixin.cursor: "pointer";
}
