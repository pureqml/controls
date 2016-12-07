WebItem {
	property string href;
	property string target;

	function _update(name, value) {
		switch(name) {
			case 'href':	this.element.dom.setAttribute('href', value); break;
			case 'target':	this.element.dom.setAttribute('target', value); break;
		}
		_globals.web.WebItem.prototype._update.apply(this, arguments);
	}

	function getTag() { return 'a' }

	function registerStyle(style, tag) {
		style.addRule(tag, "position: absolute; visibility: inherit; border-style: solid; border-width: 0px; white-space: nowrap; border-radius: 0px; opacity: 1.0; transform: none; left: 0px; top: 0px; width: 0px; height: 0px;")
	}
}
