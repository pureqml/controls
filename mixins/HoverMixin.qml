Object {
	property bool clickable: true;
	property bool value;
	property bool enabled: true;
	property string cursor: "pointer";

	constructor: { 
		this.element = this.parent.element;
		this.parent.style('cursor', this.cursor) 
	}

	onCursorChanged: 	{ this.parent.style('cursor', value) }

	function _bindClick() {
		var self = this
		if (!this._clicked)
			this._clicked = function (){ self.parent.emit.apply(self.parent, qml.core.copyArguments(arguments, 0, 'clicked'))}
		this.element.on('click', this._clicked)
	}

	onClickableChanged: {
		if (value)
			this._bindClick()
		else
			this.element.removeListener('click', this._clicked)
	}

	function _bindHover(value) {
		var self = this
		var onEnter = function() { self.value = true }
		var onLeave = function() { self.value = false }
		if (value) {
			this.element.on('mouseenter', onEnter)
			this.element.on('mouseleave', onLeave)
		} else {
			this.element.removeListener('mouseenter', onEnter)
			this.element.removeListener('mouseleave', onLeave)
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
