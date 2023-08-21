BaseInput {
	property string text;
	width: 150;
	height: 100;

	onTextChanged: {
		this._updateValue(value)
	}

	htmlTag: "textarea";

	function registerStyle(style, tag) {
		style.addRule('textarea', "position: absolute; visibility: inherit; border-style: solid; border-width: 0px; box-sizing: border-box; resize: none;")
		style.addRule('textarea:focus', "outline: none;")
	}

	constructor: {
		this.element.on("input", function() {
			this.text = this._getValue()
		}.bind(this))
	}
}
