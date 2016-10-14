Object {
	property int x1;
	property int x2;
	property int y1;
	property int y2;
	property Color color: "red";
	property int width: 2;

	constructor: {
		if (this.parent) {
			if (this.element)
				throw new Error('double ctor call')

			this.createElement('line')
		} //no parent == top level element, skip
	}

	/// specialized implementation of element creation in a certain namespace.
	function createElement(tag) {
		this.element = new _globals.core.html.Element(this, document.createElementNS('http://www.w3.org/2000/svg', tag))
		this.parent.element.append(this.element)
	}

	/// @internal
	function _update (name, value) {
		switch(name) {
			case 'color': 
			case 'width':
				log ("update stroke", name, value)
				this.element.setAttribute('style', 'stroke:' + _globals.core.normalizeColor(this.color) + ';stroke-width:' + this.width +';') 
				break;

			case 'x1':
				this.element.setAttribute('x1', value);
				break;
			case 'x2':
				this.element.setAttribute('x2', value);
				break;
			case 'y1':
				this.element.setAttribute('y1', value);
				break;
			case 'y2':
				this.element.setAttribute('y2', value);
				break;
// 				var b = this.calcBoxSize();
// 				this.element.setAttribute('x2', this.x2 - b.x);
// 				this.element.setAttribute('y1', this.y1 - b.y);
// 				this.element.setAttribute('y2', this.y2 - b.y);
// 				this.parent._update('box', b)
// 				break;
		}
		_globals.core.Object.prototype._update.apply(this, arguments);
	}

	// function calcBoxSize() {
	// 	var x, y, w, h, x1 = this.x1, x2 = this.x2, y1 = this.y1, y2 = this.y2
	// 	if (x1 < x2) {
	// 		x = x1
	// 		w = x2 - x1 + this.width
	// 	} else {
	// 		x = x2
	// 		w = x1 - x2 + this.width
	// 	}

	// 	if (y1 < y2) {
	// 		y = y1
	// 		h = y2 - y1 + this.width
	// 	} else {
	// 		y = y2
	// 		h = y1 - y2 + this.width
	// 	}

	// 	return { x: x, y: y, width: w, height: h }
	// }

	function style(name, style) {
		var element = this.element
		if (element)
			return element.style(name, style)
		else
			log('WARNING: style skipped:', name, style)
	}
}
