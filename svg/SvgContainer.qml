Item {
	/// returns tag for corresponding element
	function getTag() { return 'svg' }

	/// specialized implementation of element creation in a certain namespace.
	function createElement(tag) {
		this.element = new _globals.core.html.Element(this._context, document.createElementNS('http://www.w3.org/2000/svg', tag))
		this.parent.element.append(this.element)
	}

	/// @internal
	function _update (name, value) {
		switch(name) {
			case 'width':
				this.style('width', value);
				this.element.setAttribute('width', value);
				break;

			case 'height':
				this.style('height', value - this._topPadding);
				this.element.setAttribute('height', value);
				break;

			case 'clip':
				this.style('overflow', value? 'hidden': 'visible'); break;
				break;

			case 'x':
				this.style('left', value);
				break;

			case 'y':
				this.style('top', value);
				break;


			case 'box':
				this.x = value.x
				this.style('left', value.x);
				this.y = value.y
				this.width = value.width
				this.height = value.height
				break;
		}
		_globals.core.Object.prototype._update.apply(this, arguments);
	}
}