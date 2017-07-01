Item {
	constructor: {
		this._activityStack = []
	}

	push(name, intent, state): {
		this._activityStack.push({ "name": name, "intent": intent, "state": state })
		this.initTopIntent()
	}

	pop: {
		this._activityStack.pop()
		this.initTopIntent()
	}

	setState(state, idx): {
		this._activityStack[idx || this._activityStack.length - 1].state = state
	}

	initTopIntent: {
		var topActivity = this._activityStack[this._activityStack.length - 1]
		var children = this.children

		for (var i = 0; i < children.length; ++i) {
			if (!(children[i] instanceof _globals.controls.core.Activity))
				continue

			children[i].visible = false
			if (children[i].name === topActivity.name) {
				log("Init:", topActivity)
				children[i].init(topActivity.intent, topActivity.state)
				children[i].index = this._activityStack.length - 1
				children[i].visible = true
				children[i].setFocus()
			}
		}
	}
}
