// customize parent with class selector
Object {
	property string rules;

	///@private
	onCompleted: {
		var cn = this.parent.componentName;
		if (!_globals[cn]) {
			var style = new _globals.html5.html.Element(this, document.createElement('style'))
			log ("applying rules", this.rules)
			style.setHtml(this.rules)
			_globals.html5.html.getElement('head').append(style)
			_globals[cn] = true;
		}
		this.parent.element.addClass(cn);
	}
}
