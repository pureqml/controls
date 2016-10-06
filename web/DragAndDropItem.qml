MouseArea {
	width: 300;
	height: 300;

	onPressedChanged: {
		if (value) {
			this._startX = this.mouseX
			this._startY = this.mouseY
		}
	}

	onMouseYChanged: {
		if (this.pressed)
			this.y += this.mouseY - this._startY
	}

	onMouseXChanged: {
		if (this.pressed)
			this.x += this.mouseX - this._startX
	}
}
