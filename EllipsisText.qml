Text {
	onPaintedWidthChanged: {
		var pw = this.paintedWidth
		var w = this.width
		if (pw > w && !this._wasChanged) {
			var frac = w * 1.0 / pw
			var newLength = Math.round(frac * this.text.length) - 1
			this._wasChanged = true
			this.text = this.text.substring(0, newLength) + "..."
		}
	}
}
