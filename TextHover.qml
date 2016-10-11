Text {
	property Mixin hover: HoverMixin {}
	hover.cursor: "pointer";
	property string href;

	onHrefChanged: { this.element.dom.href = this.href }

	function getTag() {	return 'a' }
}
