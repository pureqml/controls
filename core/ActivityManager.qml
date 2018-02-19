Item {
	property int count;
	property bool keepLastActivity: true;
	property string currentActivity;

	constructor: {
		this._activityStack = []
	}

	push(name, intent, state): {
		this._activityStack.push({ "name": name, "intent": intent, "state": state })
		this.count++
		this.initTopIntent()
	}

	pop: {
		if ((this.keepLastActivity && this.count > 1) || (!this.keepLastActivity && this.count > 0)) {
			this._activityStack.pop()
			--this.count
			this.initTopIntent()
		} else {
			log("No activity to pop")
		}
	}

	setState(state, idx): {
		this._activityStack[idx || this._activityStack.length - 1].state = state
	}

	setIntent(intent, idx): {
		this._activityStack[idx || this._activityStack.length - 1].intent = intent
	}

	clear: {
		var children = this.children
		for (var i = 0; i < children.length; ++i) {
			var child = children[i]
			if (child && child instanceof _globals.controls.core.Activity)
				child.stop()
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
					state.lastActivity = this.currentActivity
				child.init(topActivity.intent, state)
				child.index = this._activityStack.length - 1
				child.start()
				child.setFocus()
				this.currentActivity = child.name
			} else {
				child.stop()
			}
		}
	}
}
