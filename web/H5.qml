Text {
	font.pixelSize: 18;
	font.weight: 300;
	wrapMode: Text.WordWrap;
	
	/// returns tag for corresponding element
	function getTag() { return 'h5' }

	function registerStyle(style, tag)
	{ style.addRule(tag, 'position: absolute; visibility: inherit; margin: 0px'); }

}