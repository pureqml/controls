Item {
	property bool smooth: true;								///< if false, image will be pixelated

	htmlTag: "canvas";

	function registerStyle(style, tag) { style.addRule(tag, "position: absolute; visibility: inherit;") }
	function getContext(name) { return this.element.dom.getContext(name) }

	onSmoothChanged: {
		this.style('image-rendering', value? 'auto': 'pixelated')
	}

	onWidthChanged: { this.element.dom.width = value; }
	onHeightChanged: { this.element.dom.height = value; }
}
