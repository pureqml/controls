Object {
	property string top;
	property string left;
	property string right;
	property string bottom;
	property string prefix;	// dynamic update not supported!

	function _update(name, value) {
		switch(name) {
			case 'top':		this.parent.style(this.prefix + 'top', value); break;
			case 'left':	this.parent.style(this.prefix + 'left', value); break;
			case 'right':	this.parent.style(this.prefix + 'right', value); break;
			case 'bottom':	this.parent.style(this.prefix + 'bottom', value); break;
		}
		_globals.core.Object.prototype._update.apply(this, arguments);
	}
}
