GridView {
	id: mosaicGrid;
	property bool hoverMode;
	property bool mobile: context.system.device === context.system.Mobile;
	property int offset;
	signal play;
	signal itemFocused;
	property int delegateRadius;
	width: 100%;
	height: 100%;
	cellWidth: (context.width > context.height ? 0.25 : 0.5) * width - spacing;
	cellHeight: cellWidth * 0.5625;
	spacing: 10s;
	keyNavigationWraps: false;
	content.cssTranslatePositioning: true;
	contentFollowsCurrentItem: !hoverMode;
	model: ListModel { }
	delegate: MosaicDelegate { }
	onKeyPressed: {
		this.hoverMode = false
		return false
	}

	fill(items, mappingFunc): {
		var res = []
		for (var i in items) {
			var row = mappingFunc(items[i])
			if (row)
				res.push(row)
		}
		this.model.assign(res)
	}
}
