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
	setState(state): { this.parent.setState(state) }
	setIntent(state): { this.parent.setIntent(state) }
	clear: { this.parent.clear() }

	onBackPressed: { this.parent.pop(); return true }
}
