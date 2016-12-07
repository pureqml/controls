Text {
	font.pixelSize: context.system.layoutType < System.Tablet ? (context.system.layoutType < System.MobileL ? 28 : 32) : 44;
	font.weight: 300;
	wrapMode: Text.WordWrap;
	font.family: "Roboto Slab";

	/// returns tag for corresponding element
	function getTag() { return 'h2' }

	function registerStyle(style, tag)
	{ style.addRule(tag, 'position: absolute; visibility: inherit; margin: 0px'); }
}