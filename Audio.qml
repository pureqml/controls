Item {
	property string source: "";

	function _update(name, value) {
		switch (name) {
			case 'source': this.element[0].setAttribute('src', value); break
		}

		qml.core.Item.prototype._update.apply(this, arguments);
	}

	constructor: {
		this.element.remove()
		this.element = $(document.createElement('audio'))
		log("Audio", this.element)
		this.parent.element.append(this.element)
	}
}
