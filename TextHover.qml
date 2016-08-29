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
		this.element = this._context.createElement('a')
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
		this.element.on('click', this._onClick.bind(this))
		this.element.on('mouseenter', this._onEnter.bind(this))
		this.element.on('mouseleave', this._onExit.bind(this))
	}
}
