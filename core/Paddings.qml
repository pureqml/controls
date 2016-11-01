/// class controlling internal paddings of the parent element
Object {
	property int left;	///< left padding
	property int right;	///< right padding
	property int top;	///< top padding
	property int bottom;	///< bottom padding

	function _update(name, value) {
		switch(name) {
			case 'left': this.parent.style('padding-left', value); break;
			case 'right': this.parent.style('padding-right', value); break;
			case 'top': this.parent.style('padding-top', value); break;
			case 'bottom': this.parent.style('padding-bottom', value); break;
		}
		_globals.core.Object.prototype._update.apply(this, arguments)
	}
}