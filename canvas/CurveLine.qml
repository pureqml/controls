Canvas {
	property int x1;
	property int y1;
	property int x2;
	property int y2;

	property enum orientation { Horizontal, Vertical };

	onX1Changed: { this.update(); }
	onX2Changed: { this.update(); }
	onY1Changed: { this.update(); }
	onY2Changed: { this.update(); }
	onOrientationChanged: { this.update(); }

	update: {
		var x1 = this.x1, x2 = this.x2, y1 = this.y1, y2 = this.y2;

		if (x1 < x2) {
			this.width = x2 - x1;
			this.x = x1;

			if (y2 > y1) {
				this.y = y1;
				y2 -= y1;
				y1 = 0;
				this.height = y2;
			} else {
				this.y = y2;
				y1 -= y2;
				y2 = 0;
				this.height = y1;
			}
		} else {
			this.width = x1 - x2;
			this.x = x2;

			if (y2 < y1) {
				this.y = y2;
				this.height = y2 = y1 - y2;
				y1 = 0;
			} else {
				this.y = y1;
				this.height = y1 = y2 - y1;
				y2 = 0;
			}
		}
		var w = this.width
		var h = this.height
		var horizontal = this.orientation == this.Horizontal

		var ctx = this.element.dom.getContext("2d")
		ctx.clearRect(0, 0, w, h);
		ctx.beginPath();
		ctx.moveTo(0, y1);

		if (horizontal)
			ctx.bezierCurveTo(w/2, y1, w/2, y2, w, y2);
		else
			ctx.bezierCurveTo(0, h/2, w, h/2, w, y2);

		ctx.stroke();
	}
}