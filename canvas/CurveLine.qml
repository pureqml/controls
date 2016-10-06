Canvas {
	property int x1;
	property int y1;
	property int x2;
	property int y2;

	onX1Changed: { this.update(); }
	onX2Changed: { this.update(); }
	onY1Changed: { this.update(); }
	onY2Changed: { this.update(); }

	update: {
		var x1, x2, y1, y2;
		if (this.y2 > this.y1) {
			this.height = this.y2 - this.y1;
			this.y = this.y1;
		} else {
			this.height = this.y1 - this.y2;
			this.y = this.y2;
		}

		if (this.x1 < this.x2) {
			this.width = this.x2 - this.x1 + 1;
			this.x = this.x1;
			x1 = 0;//this.x1;
			x2 = this.x2 - this.x1;
			if (this.y2 > this.y1) {
				y1 = 0;
				y2 = this.y2 - this.y1;
				this.height = y2 + 1;
				this.y = this.y1;
			} else {
				y2 = 0;
				y1 = this.y1 - this.y2;
				this.height = y1 + 1;
				this.y = this.y2;
			}
		} else {
			this.width = this.x1 - this.x2 + 1;
			this.x = this.x2;
			x1 = 0;//this.x2;
			x2 = this.x1 - this.x2;
			if (this.y2 < this.y1) {
				y1 = 0;
				y2 = this.y1 - this.y2;
				this.height = y2 + 1;
				this.y = this.y2;
			} else {
				y2 = 0;
				y1 = this.y2 - this.y1;
				this.height = y1 + 1;
				this.y = this.y1;
			}
		}

		this.ctx = this.element.dom.getContext("2d")
		this.ctx.beginPath();
		this.ctx.moveTo(x1, y1);
		this.ctx.bezierCurveTo((x2 - x1) / 2, y1, (x2 - x1) / 2, y2, x2, y2);
		this.ctx.stroke();
	}

	onCompleted: {
		this.update();
	}
}