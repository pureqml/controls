Text {
	wrapMode: Text.WordWrap;
	font.family: "Roboto Slab";

	/// returns tag for corresponding element
	function getTag() { return 'h2' }

	function registerStyle(style, tag)
	{ style.addRule(tag, 'position: absolute; visibility: inherit; margin: 0px'); }
}