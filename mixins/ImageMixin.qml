Image {
	anchors.fill: parent;
	width: paintedWidth;
	height: paintedHeight;

	function createElement(tag) {
		this.element = this.parent.element;
	}

	function _init() {
		var tmp = new Image()
		this._image = tmp
		this._image.onerror = this._onError.bind(this)

		var image = this
		this._image.onload = function() {
			var natW = tmp.naturalWidth, natH = tmp.naturalHeight
			var w = image.width, h = image.height
			image.paintedWidth = w
			image.paintedHeight = h

			var style = {'background-image': 'url(' + image.source + ')'}
			switch(image.fillMode) {
				case image.Stretch:
					style['background-repeat'] = 'no-repeat'
					style['background-size'] = '100% 100%'
					break;
				case image.TileVertically:
					style['background-repeat'] = 'repeat-y'
					style['background-size'] = '100%'
					break;
				case image.TileHorizontally:
					style['background-repeat'] = 'repeat-x'
					style['background-size'] = natW + 'px 100%'
					break;
				case image.Tile:
					style['background-repeat'] = 'repeat-y repeat-x'
					break;
				case image.PreserveAspectCrop:
					style['background-repeat'] = 'no-repeat'
					style['background-position'] = 'center'
					style['background-size'] = 'cover'
					break;
				case image.PreserveAspectFit:
					style['background-repeat'] = 'no-repeat'
					style['background-position'] = 'center'
					style['background-size'] = 'contain'
					var srcRatio = natW / natH, targetRatio = w / h
					if (srcRatio > targetRatio) { // img width aligned with target width
						image.paintedWidth = w;
						image.paintedHeight = w / srcRatio;
					} else {
						image.paintedHeight = h;
						image.paintedWidth = h * srcRatio;
					}
					break;
			}
			image.style(style)

			image.status = Image.Ready
		}
		this.load()
	}
}

