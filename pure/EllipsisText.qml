Text {
	property bool active: true;

	function _update(name, value) {
		switch(name) {
			case 'active': 
				this.style('text-overflow', this.value ? 'ellipsis' : 'string'); 
			}
		_globals.core.Text.prototype._update.apply(this, arguments);
	}
}
