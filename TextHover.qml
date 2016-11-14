Text {
	property Mixin hover: HoverMixin {}
	property alias cursor: hover.cursor;
	cursor: "pointer";
	property string href;

	onHrefChanged: { this.element.dom.href = this.href }

	function getTag() {	return 'a' }
}
