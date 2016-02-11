Item {
	height: 315;
	width: 560;
	property string src;
	property string vid;

	reload: {
		this.element.empty();
		var youtube = $('<iframe src="' + this.src + '" frameborder="0" allowfullscreen>');
		youtube.width(this.width);
		youtube.height(this.height);
		this.element.append(youtube);
	}

	onVidChanged: { this.src = "https://www.youtube.com/embed/" + this.vid; }
	onSrcChanged: { this.reload(); }
	onWidthChanged: { this.reload(); }
	onCompleted: { this.reload(); }
}