/// Text item but with ellipsis when text painted width reached the item width
Text {
	property bool overflowDetected;	///< overflow dectecting flag appears when text width is larger than item width
	property bool active: true;		///< flag for turning ellipsis mode on/off
	clip: true;

	updateStyle: { this.style('text-overflow', this.active ? 'ellipsis' : 'clip') }

	onActiveChanged: { this.updateStyle() }

	onCompleted: { this.updateStyle() }

	onPaintedWidthChanged: {
		var pw = value
		this.overflowDetected = value > this.width
	}
}
