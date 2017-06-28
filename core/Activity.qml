Item {
	property string name;
	visible: false;

	init(intent): { }
	pop: { this.parent.pop() }
	push(name, data): { this.parent.push(name, data) }

	onBackPressed: { this.parent.pop() }
}
