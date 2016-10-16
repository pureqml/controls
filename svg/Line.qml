SvgBase {
	property int x1;
	property int x2;
	property int y1;
	property int y2;
	property Color color: "red";
	property int width: 2;

	/// returns tag for corresponding element
	function getTag() { return 'line' }

	/// @internal
	function _update (name, value) {
		switch(name) {
			case 'color': 
			case 'width':
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
		}
		_globals.core.Object.prototype._update.apply(this, arguments);
	}
}
