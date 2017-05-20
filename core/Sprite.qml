Image {
	property int offsetX;
	property int offsetY;
	fillMode: Image.Tile;

	onOffsetYChanged,
	onOffsetXChanged: {
		this.style('background-position', '-' + this.offsetX + 'px -' + this.offsetY + 'px');
	}
}
