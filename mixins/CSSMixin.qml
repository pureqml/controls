Object {
	property string hover;
	property string generic;
	property string focus;

	onCompleted: {
		var cn = this.parent.componentName.replace(".", "");
		if (!_globals[cn]) {
			var style = new _globals.html5.html.Element(this, document.createElement('style'))
			var rules = ""
			if (this.generic.length > 0)
				rules += "." + cn + " " + this.generic;
			if (this.hover.length > 0)
				rules += "." + cn + ":hover " + this.hover;
			if (this.focus.length > 0)
				rules += "." + cn + ":focus " + this.focus;

			log ("applying rules", rules)
			style.setHtml(rules)
			_globals.html5.html.getElement('head').append(style)
			_globals[cn] = true;
		}
		this.parent.element.addClass(cn);
	}
}
