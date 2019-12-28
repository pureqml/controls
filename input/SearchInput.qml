/// HTML5 search input item
BaseInput {
	property string text;	///< input text string property
	width: 100;		///<@private
	height: 25;		///<@private
	type: "search";	///<@private

	onTextChanged: { this._updateValue(value) }

	constructor: {
		this.element.on("input", function() {
			this.text = this._getValue()
		}.bind(this))
	}
}
