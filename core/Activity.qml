Item {
	property string name;
	visible: false;

	init(intent): { }
	pop: { this.parent.pop() }
	push(name, intent, state): { this.parent.push(name, intent, state) }
	setState(state): { this.parent.setState(state) }

	onBackPressed: { this.parent.pop() }
}
