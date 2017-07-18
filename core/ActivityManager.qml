Item {
	property int count;
	property string currentActicity;

	constructor: {
		this._activityStack = []
	}

	push(name, intent, state): {
		this._activityStack.push({ "name": name, "intent": intent, "state": state })
		this.count++
		this.initTopIntent()
	}

	pop: {
		this._activityStack.pop()
		--this.count
		this.initTopIntent()
	}

	setState(state, idx): {
		this._activityStack[idx || this._activityStack.length - 1].state = state
	}

	clear: {
		var children = this.children
		for (var i = 0; i < children.length; ++i) {
			var child = children[i]
			if (child && child instanceof _globals.controls.core.Activity)
				child.visible = false
		}
		this._activityStack = []
	}

	initTopIntent: {
		if (!this._activityStack.length) {
			log("Activity stack is empty")
			return
		}

		var topActivity = this._activityStack[this._activityStack.length - 1]
		var children = this.children

		for (var i = 0; i < children.length; ++i) {
			var child = children[i]
			if (!child || !(child instanceof _globals.controls.core.Activity))
				continue

			if (child.name === topActivity.name) {
				log("Init:", topActivity)
				var state = topActivity.state || {}
				if (!state.lastActivity)
					state.lastActivity = this.currentActicity
				child.init(topActivity.intent, state)
				child.index = this._activityStack.length - 1
				child.started()
				child.visible = true
				child.setFocus()
				this.currentActicity = child.name
			} else {
				if (child.visible)
					child.stopped()
				child.visible = false
			}
		}
	}
}
