/// base sprite object
Image {
	property int offsetX;	///< sprite horizontal offset
	property int offsetY;	///< sprite vertical offset
	fillMode: Image.Tile;	///< sprite image filling mode

	onOffsetYChanged,
	onOffsetXChanged: {
		this.style('background-position', '-' + this.offsetX + 'px -' + this.offsetY + 'px');
	}
}
