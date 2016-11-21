WebItem {
	property string href;
	property string target;

	function _update(name, value) {
		switch(name) {
			case 'href':	this.element.dom.setAttribute('href', value); break;
			case 'target':	this.element.dom.setAttribute('target', value); break;
		}
		_globals.controls.WebItem.prototype._update.apply(this, arguments);
	}

	function getTag() { return 'a' }
}
