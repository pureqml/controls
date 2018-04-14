Item {
	property int count;
	property bool keepLastActivity: true;
	property string currentActivity;

	constructor: {
		this._activityStack = []
	}

	replaceTopActivity(name, intent, state): {
		if (this.count > 0) {
			this._activityStack.pop()
			this._activityStack.push({ "name": name, "intent": intent, "state": state })
			this.initTopIntent()
		} else {
			log("No activity to pop")
		}
	}

	push(name, intent, state): {
		this._activityStack.push({ "name": name, "intent": intent, "state": state })
		this.count++
		this.initTopIntent()
	}

	closeAllExcept(name): {
		var activity = this.findActivity(name)

		if (activity) {
			this.count = 1
			this._activityStack = [this._activityStack[activity.index]]
		} else {
			log("Activity", name, "not found, close all")
			this.count = 0
			this._activityStack = []
		}
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

	findActivity(name): {
		var activities = this.children.filter(function(element) {
			return element instanceof _globals.controls.core.Activity && element.name == name
		})
		if (activities && activities.length) {
			return activities[0]
		} else {
			log("Activity for name", name, "not found")
			return null
		}
	}

	setState(state, name): {
		if (!name) {
			this._activityStack[this._activityStack.length - 1].state = state
		} else {
			var activity = this.findActivity(name)
			if (activity)
				activity.state = state
		}
	}

	setIntent(intent, name): {
		if (!name) {
			this._activityStack[this._activityStack.length - 1].intent = intent
		} else {
			var activity = this.findActivity(name)
			if (activity)
				activity.intent = intent
		}
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
