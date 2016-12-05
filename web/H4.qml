Text {
	font.pixelSize: context.system.layoutType < System.Tablet ? 18 : 24;
	font.weight: 300;
	font.lineHeight: 32;
	wrapMode: Text.WordWrap;

	/// returns tag for corresponding element
	function getTag() { return 'h4' }
}