Text {
	property Mixin hoverMixin: HoverMixin {}
	property alias cursor: hoverMixin.cursor;
	property alias hover: hoverMixin.value;
	cursor: "pointer";
	property string href;

	onHrefChanged: { this.element.dom.href = this.href }

	function getTag() {	return 'a' }
}
