Text {
	constructor: { parent.__forward_text = 'text' }
	anchors.fill: parent;
	verticalAlignment: Text.AlignVCenter;
	horizontalAlignment: Text.AlignHCenter;

	function createElement(tag) {
		this.element = this.parent.element;
	}
}
