// customize parent with class selector
Object {
	property string rules;

	///@private
	onCompleted: {
		var cn = this.parent.componentName;
		if (!_globals[cn]) {
			var style = new _globals.html5.html.Element(this, document.createElement('style'))
			style.setHtml(this.rules)
			var head = _globals.html5.html.getElement(this._context, 'head')
			head.append(style)
			_globals[cn] = true;
		}
		this.parent.element.addClass(cn);
	}
}
