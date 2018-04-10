///mixin which instantiate text in component without creating extra entities
Text {
	width: 100%;
	height: 100%;
	verticalAlignment: Text.AlignVCenter;
	horizontalAlignment: Text.AlignHCenter;

	constructor: { parent.setPropertyForwardingTarget('text', 'text') }

	function _createElement(tag) {
		this.element = this.parent.element;
	}
}
