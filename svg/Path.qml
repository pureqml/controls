Object {
	property int x1;
	property int x2;
	property int y1;
	property int y2;
	property Color color: "red";
	property string fill: "none";
	property int width: 2;

	constructor: {
		if (this.parent) {
			if (this.element)
				throw new Error('double ctor call')

			this.createElement('path')
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
				this.element.setAttribute('stroke', _globals.core.normalizeColor(value)) 
				break;
			case 'fill':
				this.element.setAttribute('fill', value) 
				break;
			case 'width':
				this.element.setAttribute('stroke-width:', value) 
				break;

			case 'x1':
			case 'x2':
			case 'y1':
			case 'y2':
				this.element.setAttribute('d', this.buildPath());
				break;
		}
		_globals.core.Object.prototype._update.apply(this, arguments);
	}

	function buildPath() {
		var x1 = this.x1, x2 = this.x2, y1 = this.y1, y2 = this.y2
		var xb = (x2 - x1) / 2 + x1

		var d = "M" + x1 + "," + y1 + " C" + xb + "," + y1 + " " + xb + "," + y2 + " " + x2 + "," + y2
	 	return d;
	}

	function style(name, style) {
		var element = this.element
		if (element)
			return element.style(name, style)
		else
			log('WARNING: style skipped:', name, style)
	}
}