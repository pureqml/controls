//@using { controls.core.Activity }
//@using { controls.core.LazyActivity }
Item {
	property int count;						///< activities count
	property bool keepLastActivity: true;	///< allow to keep last activity on screen or not
	property string currentActivity;		///< current active activity name

	constructor: {
		this._activityStack = []
	}

	/**@param name:string activity name to replace
	@param intent:Object activity initial data object
	@param state:Object activity initial state object
	replace current top activity with new one*/
	replaceTopActivity(name, intent, state): {
		if (this.count > 0) {
			this._activityStack.pop()
			this._activityStack.push({ "name": name, "intent": intent, "state": state })
			this.initTopIntent()
			return true
		} else {
			log("No activity to pop")
			return false
		}
	}

	/**@param name:string activity name to push
	@param intent:Object activity initial data object
	@param state:Object activity initial state object
	push new activity to the top*/
	push(name, intent, state): {
		this._activityStack.push({ "name": name, "intent": intent, "state": state })
		this.count++
		this.initTopIntent()
	}

	/**@param name:string activity name that must stay
	close all activities in stack except 'name' activity*/
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

	/**@param count:int activities count to pop from stack
	pop top 'count' activities from the stack top*/
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
			return true
		} else {
			log("No activity to pop")
			return false
		}
	}

	/**@param name:string activity name to be removed from stack
	remove 'name' activity from stack*/
	removeActivity(name): {
		if (name == this.currentActivity) {
			this.pop()
		} else {
			var index = -1
			for (var i = 0; i < this._activityStack.length; ++i) {
				if (this._activityStack[i].name == name) {
					index = i
					break
				}
			}
			if (index < 0) {
				log("Activity", name, "not found")
				return
			}
			this._activityStack.splice(index, 1)
		}
	}

	/**@param state:Object activity initial state object
	pop top activity and send 'state' to the next activity*/
	popWithState(state): {
		if ((this.keepLastActivity && this.count > 1) || (!this.keepLastActivity && this.count > 0)) {
			this._activityStack.pop()
			--this.count
			this.setState(state)
			this.initTopIntent()
			return true
		} else {
			log("No activity to pop")
			return false
		}
	}

	/**@param name:string activity name to find
	find 'name' activity in stack*/
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

	///@private
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

	/**@param state:Object new state for corresponded activity
	@param name:string activity that state will be changed
	set state of 'name' activity*/
	setState(state, name): {
		if (!name) {
			this._activityStack[this._activityStack.length - 1].state = state
		} else {
			var activity = this.createActivity(name)
			if (activity)
				activity.state = state
		}
	}

	/**@param intent:Object new intent for corresponded activity
	@param name:string activity that state will be changed
	set intent of 'name' activity*/
	setIntent(intent, name): {
		if (!name) {
			this._activityStack[this._activityStack.length - 1].intent = intent
		} else {
			var activity = this.createActivity(name)
			if (activity)
				activity.intent = intent
		}
	}

	/**@param name:string activity that state will be changed
	check is 'name' activity in stack or not*/
	isActivityInStack(name): {
		var activities = this._activityStack.filter(function(element) {
			return element.name == name
		})
		return activities && activities.length > 0
	}

	///clear activities stack
	clear: {
		var children = this.children
		for (var i = 0; i < children.length; ++i) {
			var child = children[i]
			if (child && child instanceof _globals.controls.core.Activity)
				child.stop()
		}
		this._activityStack = []
	}

	///@private
	initTopIntent: {
		try {
			this._initTopIntent()
		} catch(ex) {
			log('initTopIntent failed:', ex)
			this.pop()
		}
	}

	///@private
	_initTopIntent: {
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
