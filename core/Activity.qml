Item {
	signal started;
	signal stopped;
	property string name;
	visible: false;

	start: {
		this.style('display', 'block')
		this.visible = true
		this.started()
	}

	stop: {
		this.style('display', 'none')
		this.visible = false
		this.stopped()
	}

	init(intent): { }
	pop: { this.parent.pop() }
	push(name, intent, state): { this.parent.push(name, intent, state) }
	replaceTopActivity(name, intent, state): { this.parent.replaceTopActivity(name, intent, state) }
	setState(state, name): { this.parent.setState(state, name) }
	setIntent(state, name): { this.parent.setIntent(state, name) }
	clear: { this.parent.clear() }

	onBackPressed: { this.parent.pop(); return true }
}
