Item {
	property string text;

	onTextChanged: {
		this.element.setHtml(this.text, this)
	}

	onCompleted: {
		this.element.setHtml(this.text, this)
	}

	function registerStyle(style, tag)
	{ style.addRule(tag, 'position: default; visibility: inherit; margin: 0px; padding: 0px; border-collapse: collapse;'); }
}
