Item {
	function getTag() {	return 'canvas'	}

	function registerStyle(style, tag) {
		style.addRule(tag, "position: absolute; visibility: inherit;")
	}

	onWidthChanged: { this.element.dom.width = value; }

	onHeightChanged: { this.element.dom.height = value; }
}