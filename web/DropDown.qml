///html drop down list chooser
ElementWithModel {
	property Font font: Font {}
	property Color color: "#000";
	property int currentIndex;		///< current option index
	property int count;			///< drop down options count
	property string value;			///< current option value
	property string text;			///< current option text
	property bool disabled: false;		///< set true to disable changing selection
	property string valueProperty: "value";
	property string textProperty: "text";
	width: 100;		///<@private
	height: 40;		///<@private

	constructor: {
		this.count = 0
		this.element.style('pointer-events', 'auto')
		this.element.style('touch-action', 'auto')
		this.element.on("change", function() {
			this.value = this.element.dom.value
			var idx = this.element.dom.selectedIndex
			this.currentIndex = idx
			this.text = this.element.dom[idx].label
		}.bind(this))
		this.element.style('pointer-events', 'auto')
		this.element.style('touch-action', 'auto')
	}

	onDisabledChanged: {
		this.element.dom.disabled = this.disabled;
	}

	/// @private
	onWidthChanged, onHeightChanged: { this._updateSize(); }

	htmlTag: "select";

	/// @private
	function registerStyle(style, tag)
	{ style.addRule(tag, "position: absolute; visibility: inherit; margin: 0px;") }

	/// @private
	function _updateSize() {
		var style = { width: this.width, height: this.height }
		this.style(style)
	}

	/**
	 * add option into select
	 * @param {string} value - new option value
	 * @param {string} text - new option text
	 */
	append(value, text): {
		this.element.append(this._createOption(value, text))
		++this.count
	}

	///remove all options from dropdown list
	clear: {
		if (!this.element.dom.options || !this.element.dom.options.length)
			return

		var options = this.element.dom.options
		for (var i = options.length - 1; i >= 0; --i)
			options[i].remove()
		this.count = 0;
	}

	/**
	 * remove option from drop down list by index
	 * @param {number} idx - new option value
	 */
	remove(idx): {
		if (!this.element.dom.options || idx >= this.element.dom.options.length || idx < 0) {
			log("bad index")
			return
		}
		this.element.dom.options[idx].remove()
		--this.count
	}

	onCurrentIndexChanged: {
		this.element.dom.value = this.element.dom.options[value].value
		this.value = this.element.dom.value;
	}

	onCountChanged: {
		if (value == 1) {
			this.value = this.element.dom.value
			this.text = this.element.dom[0].label
			this.currentIndex = 0
		}
	}

	/// @private
	function _createOption(value, text) {
		var option = this._context.createElement('option')
		option.setAttribute('value', value)
		option.setHtml(text)
		return option
	}

	/// @private
	function _createValue(row) {
		var value = row[this.valueProperty]
		var text = row[this.textProperty]

		if (this.trace)
			log("DataList::createValue", value)

		var el = this._createOption(value, text)
		return el.dom
	}

	/// @private
	function _updateValue(el, row) {
		var value = row[this.valueProperty]
		var text = row[this.textProperty]

		if (this.trace)
			log("DataList::updateValue", value)

		el.setAttribute("value", value)
		el.innerHTML = text
		return el
	}
}
