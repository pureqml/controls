WebItem {
	property string href;

	onHrefChanged: {
		this.element.attr("href", this.href)
	}

	constructor: {
		this.element.remove();
		this.element = $(this._context.createElement('a'))
		this.parent.element.append(this.element)
	}
}
