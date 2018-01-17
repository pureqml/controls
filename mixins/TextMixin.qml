Text {
	constructor: { parent.setPropertyForwardingTarget('text', 'text') }
	anchors.fill: parent;
	verticalAlignment: Text.AlignVCenter;
	horizontalAlignment: Text.AlignHCenter;

	function createElement(tag) {
		this.element = this.parent.element;
	}
}
