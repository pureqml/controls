Item {
	property string name;

	signal started;
	signal stopped;

	init(intent): { }
	pop: { this.parent.pop() }
	push(name, intent, state): { this.parent.push(name, intent, state) }
	replaceTopActivity(name, intent, state): { this.parent.replaceTopActivity(name, intent, state) }
	setState(state, name): { this.parent.setState(state, name) }
	setIntent(state, name): { this.parent.setIntent(state, name) }
	clear: { this.parent.clear() }

	onBackPressed: { this.parent.pop(); return true }
}
