Layout {
	property string position;
	property bool vertical: width < 600;
	property bool collapsed: true;
	spacing: vertical ? 5 : 30;
	height: vertical && collapsed ? 50 : contentHeight;
	clip: true;

	onPositionChanged: {
		this.style('position', value)
	}

	addChild(child): {
		_globals.core.Item.prototype.addChild.apply(this, arguments)
		child.onChanged('height', this._layout.bind(this))
		child.onChanged('width', this._layout.bind(this))
		child.onChanged('recursiveVisible', this._layout.bind(this))
	}

	_layout: {
//		log ("Navbar layout called");
		var children = this.children;
		var cX = this.anchors.leftMargin, cY = 0, xMax = 0, yMax = 0;
		for(var i = 0; i < children.length; ++i) {
			var c = children[i]

			if (this.vertical)
			{
				if (c.recursiveVisible && c instanceof _globals.controls.web.NavbarItem) {
					c.x = cX + c.anchors.leftMargin;
					c.y = cY + c.anchors.topMargin;
					cY = c.y + c.height + this.spacing;
					xMax = xMax > c.width ? xMax : c.width;
					yMax = cY;
				}
			}
			else {//horizontal
				if (c.recursiveVisible && c instanceof _globals.controls.web.NavbarItem) {
					c.y = 0;
					c.x = cX + c.anchors.leftMargin;
					cX = c.x + c.width + this.spacing;
					yMax = yMax > c.height ? yMax : c.height;
					xMax = cX;
				}
			}
		}
		this.contentHeight = yMax;
		this.contentWidth = xMax;
	}

	onSpacingChanged: { this._layout(); }
	onVerticalChanged: { this._layout(); }
}
