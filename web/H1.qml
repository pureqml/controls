Text {
//	font.pixelSize: context.system.layoutType < System.Tablet ? 32 : 62;
	font.weight: 300;
	wrapMode: Text.WordWrap;
	font.family: "Roboto Slab";

	/// returns tag for corresponding element
	function getTag() { return 'h1' }

	function registerStyle(style, tag)
	{ style.addRule(tag, 'position: absolute; visibility: inherit; margin: 0px'); }
}