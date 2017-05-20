WebItem {
	property string href;
	property string target;

	onHrefChanged: { this.element.dom.setAttribute('href', value); }
	onTargetChanged: { this.element.dom.setAttribute('target', value); }

	function getTag() { return 'a' }

	function registerStyle(style, tag) {
		style.addRule(tag, "text-decoration: none; position: absolute; visibility: inherit; border-style: solid; border-width: 0px; white-space: nowrap; border-radius: 0px; opacity: 1.0; transform: none; left: 0px; top: 0px; width: 0px; height: 0px;")
	}
}
