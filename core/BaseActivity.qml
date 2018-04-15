Item {
	property string name;
	property Item manager: parent;

	signal started;
	signal stopped;

	init(intent): { }
	pop: { this.manager.pop() }
	push(name, intent, state): { this.manager.push(name, intent, state) }
	replaceTopActivity(name, intent, state): { this.manager.replaceTopActivity(name, intent, state) }
	setState(state, name): { this.manager.setState(state, name) }
	setIntent(state, name): { this.manager.setIntent(state, name) }
	clear: { this.manager.clear() }

	onBackPressed: { this.manager.pop(); return true }
}
