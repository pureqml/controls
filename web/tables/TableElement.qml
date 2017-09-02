Item {
	property string text;

	onTextChanged: {
		this.element.setHtml(this.text, this)
	}

	onCompleted: {
		this.element.setHtml(this.text, this)
	}

	__update(name, value) : {
		log(name, value)
	}

	function registerStyle(style, tag)
	{ style.addRule(tag, 'position: default; visibility: inherit; margin: 0px; padding: 0px; border-collapse: collapse;'); }
}
