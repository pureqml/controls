Text {
	signal clicked;
	property bool hover;
	property string cursor: "pointer";

	property string href;

	onHrefChanged: {
		this.element.attr("href", this.href)
	}

	constructor: {
		this.element.remove();
		this.element = this.getContext().createElement('a')
		this.parent.element.append(this.element);
		this.style('cursor', this.cursor);
	}

	onCursorChanged: 	{ this.style('cursor', value) }

	_onEnter: {
		if (this.recursiveVisible)
			this.hover = true;
	}

	_onExit: {
		if (this.recursiveVisible)
			this.hover = false;
	}

	_onClick: {
		if (this.recursiveVisible)
			this.clicked()
	}

	onCompleted: {
		var self = this;
		self.element.click(self._onClick.bind(self))
		self.element.hover(self._onEnter.bind(self), self._onExit.bind(self)) //fixme: unsubscribe
	}
}
