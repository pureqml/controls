BaseView {
	property enum orientation { Vertical, Horizontal };

	constructor: {
		this._oldIndex = 0
	}

	function positionViewAtIndex(idx) { }

	function _layout() {
		if (!this.recursiveVisible)
			return

		var model = this.model;
		if (!model)
			return

		this.count = model.count

		var horizontal = this.orientation === this.Horizontal
		var items = this._items

		if (!items.length || !this.count) {
			this.layoutFinished()
			return
		}

		var w = this.width
		var h = this.height
		var created = false
		var size = horizontal ? w : h
		var currentIndex = this.currentIndex
		var n = items.length
		var spacing = this.spacing

		var prerender = this.prerender * size
		var leftMargin = -prerender
		var rightMargin = size + prerender

		var pos = w / 2
		var leftIn = true, rightIn = true
		for(var i = 0; i < n && leftIn && rightIn; ++i) {
			var di = (i & 1)? ((1 - i) / 2 - 1): i / 2
			var idx = (n + currentIndex + di) % n
			var item = this._createDelegate(idx)
			var itemPos
			if (di < 0) {
				var next = this._createDelegate((idx + 1) % n)
				itemPos = next.viewX - spacing - item.width
				if (itemPos < leftMargin)
					leftIn = false
			} else if (di > 0) {
				var prev = this._createDelegate((idx + n - 1) % n)
				itemPos = prev.viewX + prev.width + spacing
				if (itemPos >= rightMargin)
					rightIn = false
			} else //currentIndex 0
				itemPos = pos - item.width / 2

			if (currentIndex == idx && !item.focused) {
				this.focusChild(item)
				if (this.contentFollowsCurrentItem)
					this.positionViewAtIndex(i)
			}

			item.visibleInView = true

			item.viewX = itemPos
		}
	}

	onKeyPressed: {
		if (!this.handleNavigationKeys)
			return false;

		var horizontal = this.orientation == this.Horizontal
		if (horizontal) {
			if (key == 'Left') {
				--this.currentIndex;
				return true;
			} else if (key == 'Right') {
				++this.currentIndex;
				return true;
			}
		} else {
			if (key == 'Up') {
				if (!this.currentIndex && !this.keyNavigationWraps)
					return false;
				--this.currentIndex;
				return true;
			} else if (key == 'Down') {
				if (this.currentIndex == this.count - 1 && !this.keyNavigationWraps)
					return false;
				++this.currentIndex;
				return true;
			}
		}
	}

	onOrientationChanged: { this._scheduleLayout() }
	onCurrentIndexChanged: {
		if (value !== this._oldIndex) {
			log('currentIndexChanged', value, this._oldIndex)
			this._oldIndex = value
		}
	}
}
