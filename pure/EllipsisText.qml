Text {
	property bool active: true;
	clip: true;

	updateStyle: { this.style('text-overflow', this.active ? 'ellipsis' : 'string') }

	onActiveChanged: { this.updateStyle() }

	onCompleted: { this.updateStyle() }
}
