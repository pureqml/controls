Object {
	constructor: {
		if (this.parent) {
			if (this.element)
				throw new Error('double ctor call')

			this.createElement(this.getTag())
		} //no parent == top level element, skip
	}

	/// specialized implementation of element creation in a certain namespace.
	function createElement(tag) {
		this.element = new _globals.core.html.Element(this, document.createElementNS('http://www.w3.org/2000/svg', tag))
		this.parent.element.append(this.element)
	}

	/// returns tag for corresponding element
	function getTag() { return 'svg' }

	function style(name, style) {
		var element = this.element
		if (element)
			return element.style(name, style)
		else
			log('WARNING: style skipped:', name, style)
	}
}