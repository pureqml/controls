///mixin which instantiate text in component without creating extra entities
Text {
	width: 100%;
	height: 100%;
	verticalAlignment: Text.AlignVCenter;
	horizontalAlignment: Text.AlignHCenter;

	prototypeConstructor: { TextMixinPrototype.defaultProperty = 'text' }

	function _createElement(tag) {
		this.element = this.parent.element;
	}
}
