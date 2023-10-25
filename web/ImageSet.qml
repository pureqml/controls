Item {
	property string srcSet;

	function getTag() { return 'img' }

	onSrcSetChanged: {
		this.element.setAttribute('srcset', value)
	}
}
