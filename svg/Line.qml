Object {
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
				log ("update stroke", name, value)
				if (this.element)
					this.element.setAttribute('style', 'stroke:' + _globals.core.normalizeColor(this.color) + ';stroke-width:' + this.width +';')
				else
					log('warning: update skipped', name, value)
				break;

			case 'x1':
				if (this.element)
					this.element.setAttribute('x1', value);
				else
					log('warning: update skipped', name, value)
				break;
			case 'x2':
				if (this.element)
					this.element.setAttribute('x2', value);
				else
					log('warning: update skipped', name, value)
				break;
			case 'y1':
				if (this.element)
					this.element.setAttribute('y1', value);
				else
					log('warning: update skipped', name, value)
				break;
			case 'y2':
				if (this.element)
					this.element.setAttribute('y2', value);
				else
					log('warning: update skipped', name, value)
				break;
		}
		_globals.core.Object.prototype._update.apply(this, arguments);
	}
}
