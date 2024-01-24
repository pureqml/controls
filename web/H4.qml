Text {
	wrapMode: Text.WordWrap;

	/// returns tag for corresponding element
	function getTag() { return 'h4' }

	function registerStyle(style, tag)
	{ style.addRule(tag, 'position: absolute; visibility: inherit; margin: 0px'); }

}