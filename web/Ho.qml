Object {
	property string width;
	property string height;
	property string top;
	property string left;
	property string right;
	property string bottom;
	property string html;
	property string display;
	property string float;
	property string boxSizing: "border-box";
	property string position;
	property real opacity: 1;
	property real radius;
	property real rotate;
	property bool clip;
	property int z;
	property color color: "#0000";
	property Font font: Font {}
	property Box margin: Box { prefix: "margin-"; }
	property Box padding: Box { prefix: "padding-"; }

	function style(name, style) {
		if (style !== undefined) {
			if (style !== '') //fixme: replace it with explicit 'undefined' syntax
				this._styles[name] = style
			else
				delete this._styles[name]
			this._updateStyle()
		} else if (name instanceof Object) { //style({ }) assignment
			for(var k in name) {
				var value = name[k]
				if (value !== '') //fixme: replace it with explicit 'undefined' syntax
					this._styles[k] = value
				else
					delete this._styles[k]
			}
			this._updateStyle()
		}
		else
			return this._styles[name]
	}

	function _updateStyle() {
		var element = this.element
		if (!element)
			return

		/** @const */
		var cssUnits = {
			'left': 'px',
			'top': 'px',
			'width': 'px',
			'height': 'px',

			'border-radius': 'px',
			'border-width': 'px',

			'margin-left': 'px',
			'margin-top': 'px',
			'margin-right': 'px',
			'margin-bottom': 'px'
		}

		var rules = []
		for(var name in this._styles) {
			var value = this._styles[name]
			var rule = []

			var prefixedName = this._get('context').getPrefixedName(name)
			if (prefixedName === undefined)
				this._modernizrCache[name] = prefixedName = window.Modernizr.prefixedCSS(name)
			rule.push(prefixedName !== false? prefixedName: name)
			if (Array.isArray(value))
				value = value.join(',')

			var unit = (typeof value === 'number')? cssUnits[name] || '': ''
			value += unit

			var prefixedValue = window.Modernizr.prefixedCSSValue(name, value)
			rule.push(prefixedValue !== false? prefixedValue: value)

			rules.push(rule.join(':'))
		}

		element.dom.setAttribute('style', rules.join(';'))
	}

	function _update (name, value) {
		switch (name) {
			case 'width':		this.style('width', value); break;
			case 'height':		this.style('height', value); break;
			case 'x':
			case 'left':		this.style('left', value); break;
			case 'y':
			case 'top':			this.style('top', value); break;
			case 'display':		this.style('display', value); break;
			case 'color': 		this.style('background-color', qml.core.normalizeColor(value)); break;
			case 'float':		this.style('float', value); break;
			case 'boxSizing':	this.style('box-sizing', value); break;
			case 'position':	this.style('position', value); break;
			case 'html':		this.element.append(value); break;
			case 'opacity':		if (this.element) this.style('opacity', value); break;
			case 'z':			this.style('z-index', value); break;
			case 'radius':		this.style('border-radius', value); break;
			case 'clip':		this.style('overflow', value? 'hidden': 'visible'); break;
			case 'rotate':		this.style('transform', 'rotate(' + value + 'deg)'); break
		}
		qml.core.Object.prototype._update.apply(this, arguments);
	}

	constructor: {
		this._styles = {}
		if (this.parent) {
			if (this.element)
				throw "double ctor call"

			this.element = this._context.createElement('div')
			this.parent.element.append(this.element)
		}
	}
}
