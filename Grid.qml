MouseArea {
	property int maxWidth: 1000;
	property int spacing;

	updateSize: {
		var children = this.children;
		var cX = 0, cY = 0, xMax = 0, yMax = 0;
		for(var i = 0; i < children.length; ++i) {
			var c = children[i]
			if (c.recursiveVisible) {
				if (this.maxWidth - cX < c.width) {
					c.x = 0;
					c.y = yMax + c.anchors.topMargin;// + (cY === 0 ? 0 : this.spacing);
					cY = yMax;// + this.spacing;
					yMax = c.y + c.height + this.spacing;
				} else {
					c.x = cX;
					c.y = cY + c.anchors.topMargin;
				}
				if (yMax < c.y + c.height)
					yMax = c.y + c.height + this.spacing;
				if (xMax < c.x + c.width)
					xMax = c.x + c.width;
				cX = c.x + c.width + this.spacing;
			}
		}
		this.height = yMax;
		this.width = xMax;
	}

	onCompleted: { this.updateSize(); }
	onMaxWidthChanged: { this.updateSize(); }
}
