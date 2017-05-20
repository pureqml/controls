Text {
	property bool active: true;

	onActiveChanged: { this.style('text-overflow', this.value ? 'ellipsis' : 'string'); }
}
