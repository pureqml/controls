//@using { controls.core.Activity }
//@using { controls.core.LazyActivity }
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
			this._activityStack = [activity]
		} else {
			log("Activity", name, "not found, close all")
			this.count = 0
			this._activityStack = []
		}
		if (this.currentActivity != name)
			this.initTopIntent()
	}

	pop(count): {
		if ((this.keepLastActivity && this.count > 1) || (!this.keepLastActivity && this.count > 0)) {
			var popActivitiesCount = 1
			if (count === undefined)
				popActivitiesCount = 1
			else if (count > this.count - 1 && this.keepLastActivity)
				popActivitiesCount = this.count - 1
			else if (count > this.count && !this.keepLastActivity)
				popActivitiesCount = this.count
			else
				popActivitiesCount = count

			this._activityStack.splice(-popActivitiesCount, popActivitiesCount)
			this.count -= popActivitiesCount
			this.initTopIntent()
		} else {
			log("No activity to pop")
		}
	}

	popWithState(state): {
		if ((this.keepLastActivity && this.count > 1) || (!this.keepLastActivity && this.count > 0)) {
			this._activityStack.pop()
			--this.count
			this.setState(state)
			this.initTopIntent()
		} else {
			log("No activity to pop")
		}
	}

	findActivity(name): {
		var activities = this.children.filter(function(element) {
			return element instanceof _globals.controls.core.BaseActivity && element.name == name
		})

		var activity = null
		if (activities && activities.length)
			activity = activities[0].getActivity()

		if (!activity)
			log("Activity for name", name, "not found")

		return activity
	}

	createActivity(name): {
		var activity = this.findActivity(name)
		if (activity)
			return activity
		var activities = this.children.filter(function(element) {
			return element instanceof _globals.controls.core.LazyActivity && element.name == name
		})
		if (activities && activities.length) {
			activity = activities[0]
			return activity.createActivity()
		} else {
			log("Activity for name", name, "not found")
			return null
		}
	}

	setState(state, name): {
		if (!name) {
			this._activityStack[this._activityStack.length - 1].state = state
		} else {
			var activity = this.createActivity(name)
			if (activity)
				activity.state = state
		}
	}

	setIntent(intent, name): {
		if (!name) {
			this._activityStack[this._activityStack.length - 1].intent = intent
		} else {
			var activity = this.createActivity(name)
			if (activity)
				activity.intent = intent
		}
	}

	isActivityInStack(name): {
		var activities = this._activityStack.filter(function(element) {
			return element instanceof _globals.controls.core.BaseActivity && element.name == name
		})
		return activities && activities.length > 0
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

		log('initTopIntent: ' + topActivity.name)
		for (var i = 0; i < children.length; ++i) {
			var child = children[i]
			if (!child || !(child instanceof _globals.controls.core.BaseActivity))
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
