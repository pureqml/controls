Image {
	property int offsetX;
	property int offsetY;
	fillMode: Image.Tile;

	function _update(name, value) {
		switch(name) {
			case 'offsetY':
			case 'offsetX':
				this.style('background-position', '-' + this.offsetX + 'px -' + this.offsetY + 'px');
				break;
		}
		_globals.core.Image.prototype._update.apply(this, arguments);
	}
}