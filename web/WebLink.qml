WebItem {
	property string href;

	onHrefChanged: {
		this.element.dom.href = this.href
	}

	function getTag() {	return 'a' }
}
