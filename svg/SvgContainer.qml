Item {
	htmlTag: "svg";

	/// @private
	function registerStyle(style, tag) {
		style.addRule(tag, 'position: absolute; visibility: inherit; overflow: visible;')
	}

	/// specialized implementation of element creation in a certain namespace.
	function _createElement(tag) {
		this._attachElement(new _globals.html5.html.Element(this._context, document.createElementNS('http://www.w3.org/2000/svg', tag)))
	}

	onWidthChanged: {
		this.style('width', value);
		this.element.setAttribute('width', value);
	}

	onHeightChanged: {
		this.style('height', value - this._topPadding);
		this.element.setAttribute('height', value);
	}

	onYChanged: { this.style('top', value); }
	onXChanged: { this.style('left', value); }
	onClipChanged: { this.style('overflow', value? 'hidden': 'visible'); }
}
