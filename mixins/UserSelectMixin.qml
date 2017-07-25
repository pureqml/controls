///This object controls how the text is allowed to be selected
Object {
	property enum value { None, Text, All };	///< text selection mode enumeration

	///@private
	_updateValue: {
		var userSelectValue
		switch(this.value) {
			case this.None:	userSelectValue = "none"; break
			case this.Text:	userSelectValue = "text"; break
			case this.All:	userSelectValue = "All"; break
		}
		this.parent.style(this._prefixedName, userSelectValue)
	}

	onValueChanged: { this._updateValue() }

	constructor: {
		this._prefixedName = window.Modernizr.prefixedCSS('user-select')
		this._updateValue()
	}
}
