Text {
	wrapMode: Text.WordWrap;
	font.family: "Roboto Slab";

	htmlTag: "h1";

	function registerStyle(style, tag)
	{ style.addRule(tag, 'position: absolute; visibility: inherit; margin: 0px'); }
}