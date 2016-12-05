Text {
	font.pixelSize: context.system.layoutType < System.Tablet ? 20 : 28;
	font.weight: 300;
	wrapMode: Text.WordWrap;
	font.family: "Roboto Slab";

	/// returns tag for corresponding element
	function getTag() { return 'h3' }
}