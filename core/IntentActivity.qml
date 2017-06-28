Item {
	constructor: {
		this._intentStack = []
	}

	push(name, intent): {
		this._intentStack.push({ "name": name, "intent": intent })
		this.initLastIntent()
	}

	pop: {
		this._intentStack.pop()
		this.initLastIntent()
	}

	initLastIntent: {
		var lastIntent = this._intentStack[this._intentStack.length - 1]
		var children = this.children

		for (var i = 0; i < children.length; ++i) {
			if (!children[i].name || !children[i].init)
				continue

			children[i].visible = false
			if (children[i].name == lastIntent.name) {
				log("Init:", lastIntent)
				children[i].init(lastIntent.intent)
				children[i].visible = true
				children[i].setFocus()
			}
		}
	}
}
