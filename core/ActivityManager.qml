Item {
	constructor: {
		this._activityStack = []
	}

	push(name, intent): {
		this._activityStack.push({ "name": name, "intent": intent })
		this.initTopIntent()
	}

	pop: {
		this._activityStack.pop()
		this.initTopIntent()
	}

	initTopIntent: {
		var topIntent = this._activityStack[this._activityStack.length - 1]
		var children = this.children

		for (var i = 0; i < children.length; ++i) {
			if (!children[i] instanceof _globals.controls.core.Activity)
				continue

			children[i].visible = false
			if (children[i].name === topIntent.name) {
				log("Init:", topIntent)
				children[i].init(topIntent.intent)
				children[i].visible = true
				children[i].setFocus()
			}
		}
	}
}
