Object {
	property real xs: 100;
	property real sm: 0;
	property real md: 0;
	property real lg: 0;
	property int globalWidth: context.width;

	function _update(name, value) {
		switch (name) {
			case 'globalWidth':
				this._calculate(); 
				break
		}
		_globals.core.Object.prototype._update.apply(this, arguments);
	}

	function _calculate() {
		var gw = this.globalWidth;
		if (gw > 1200)
			this.parent.width = this.parent.parent.width * (this.lg || this.md || this.sm || this.xs) / 100
		else if (gw > 992)
			this.parent.width = this.parent.parent.width * (this.md || this.sm || this.xs) / 100
		else if (gw > 768)
			this.parent.width = this.parent.parent.width * (this.sm || this.xs) / 100
		else
			this.parent.width = this.parent.parent.width * this.xs / 100
	}

	onCompleted: {
		this._calculate();
	}
}