Text {
	property int linesCount: 2;
	wrapMode: Text.WordWrap;
	height: font.pixelSize * font.lineHeight * linesCount;
	clip: true;

	onLinesCountChanged: {
		this.style('line-clamp', this.linesCount);
		this.style('-webkit-line-clamp', this.linesCount);
	}

	onCompleted: {
		this.style("display", "block");
		this.style("display", "-webkit-box");
		this.style("text-overflow", "ellipsis");
		this.style('box-orient', "vertical");
		this.style('-webkit-box-orient', "vertical");
		this.style('line-clamp', this.linesCount);
		this.style('-webkit-line-clamp', this.linesCount);
	}
}
