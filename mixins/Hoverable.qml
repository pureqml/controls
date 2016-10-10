Object {
	signal clicked;
	property bool clickable: true;
	property bool value;
	property bool enabled: true;
	property string cursor: "pointer";

	constructor:		{ this.parent.style('cursor', this.cursor) }
	onCursorChanged: 	{ this.parent.style('cursor', value) }

	function createElement(tag) {
		this.element = this.parent.element;
	}

	function _bindClick() {
		var self = this
		if (!this._clicked)
			this._clicked = function (){ self.parent.emit.apply(self.parent, qml.core.copyArguments(arguments, 0, 'clicked'))}
		log("binding click")
		this.parent.element.on('click', this._clicked)
	}

	onClickableChanged: {
		if (value)
			this._bindClick()
		else
			this.parent.element.removeListener('click', this._clicked)
	}

	function _bindHover(value) {
		var self = this
		var onEnter = function() { self.value = true }
		var onLeave = function() { self.value = false }
		if (value) {
			this.parent.element.on('mouseenter', onEnter)
			this.parent.element.on('mouseleave', onLeave)
		} else {
			this.parent.element.removeListener('mouseenter', onEnter)
			this.parent.element.removeListener('mouseleave', onLeave)
		}
	}

	onEnabledChanged: {
		this._bindHover(value)
	}

	onCompleted: {
		if (this.clickable)
			this._bindClick()
		if (this.enabled)
			this._bindHover(true)
	}
}
