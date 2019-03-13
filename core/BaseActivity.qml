///base activity control
Item {
	property bool active;			///< active at the moment
	property string name;			///< activity name
	property Item manager: parent;	///< activities manager

	visible: active;

	signal started;		///< activity started signal
	signal stopped;		///< activity stopped signal

	/**
	 * Initialize activity
	 * @param {object} intent - required data for activity
	 * @param {object} state - init activity state
	 */
	init(intent, state): { }

	/**
	 * Push activity in manager activities stack to show it
	 * @param {string} name - activity name
	 * @param {object} intent - required data for activity
	 * @param {object} state - init activity state
	 */
	push(name, intent, state): { this.manager.push(name, intent, state) }

	/**
	 * Replace top activity with new one
	 * @param {string} name - activity name
	 * @param {object} intent - required data for activity
	 * @param {object} state - init activity state
	 */
	replaceTopActivity(name, intent, state): { this.manager.replaceTopActivity(name, intent, state) }

	/**
	 * Change activity state
	 * @param {object} state - init activity state
	 * @param {string} name - activity name
	 */
	setState(state, name): { this.manager.setState(state, name) }

	/**
	 * Close all activities in manager except activity with corresponded name
	 * @param {string} name - activity name
	 */
	closeAllExcept(name): { this.manager.closeAllExcept(name) }

	/**
	 * Remove activity from stack by its name
	 * @param {string} name - activity name
	 */
	removeActivity(name): { this.manager.removeActivity(name) }

	/**
	 * Change activity intent
	 * @param {object} state - init activity state
	 * @param {string} name - activity name
	 */
	setIntent(state, name): { this.manager.setIntent(state, name) }

	///clear all activities from manager stack
	clear: { this.manager.clear() }

	/// Pop current top activity from manager stack
	pop(count): { this.manager.pop(count) }

	/// Pop current top activity from manager stack and send state to the top activity
	popWithState(state): { this.manager.popWithState(state) }

	///@private
	onBackPressed: { this.manager.pop(); return true }
}
