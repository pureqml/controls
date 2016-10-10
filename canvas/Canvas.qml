Item {
	function getTag() {	return 'canvas'	}

	onWidthChanged: { this.element.dom.width = value; }

	onHeightChanged: { this.element.dom.height = value; }
}