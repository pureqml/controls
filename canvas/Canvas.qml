Item {
	constructor: {
		this.ctx = this.element.dom.getContext("2d")
	}

	function clearAll() {
		this.ctx.clearRect(0, 0, this.width, this.height);
	}

	function getTag() {	return 'canvas'	}

	function registerStyle(style, tag) {
		style.addRule(tag, "position: absolute; visibility: inherit;")
	}

	onWidthChanged: { this.element.dom.width = value; }

	onHeightChanged: { this.element.dom.height = value; }
}