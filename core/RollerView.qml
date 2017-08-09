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

			item.visibleInView = true
			item.viewX = itemPos

			if (currentIndex == idx && !item.focused) {
				this.focusChild(item)
				if (this.contentFollowsCurrentItem)
					this.positionViewAtIndex(i)
			}
		}

		for(; i < n; ++i) {
			var di = (i & 1)? ((1 - i) / 2 - 1): i / 2
			var idx = (n + currentIndex + di) % n
			var item = items[idx]
			if (item)
				item.visibleInView = false
		}


		var animationDuration = this.animationDuration
		this.animationDuration = 0
		this.contentX = 0
		this.content.element.updateStyle()
		this.animationDuration = animationDuration
	}

	function next() {
		var n = this._items.length
		if (n > 1)
			this.currentIndex = (this.currentIndex + 1) % n
	}

	function prev() {
		var n = this._items.length
		if (n > 1)
			this.currentIndex = (this.currentIndex + n - 1) % n
	}

	onKeyPressed: {
		if (!this.handleNavigationKeys)
			return false;

		var horizontal = this.orientation == this.Horizontal
		if (horizontal) {
			if (key == 'Left') {
				this.prev()
				return true;
			} else if (key == 'Right') {
				this.next()
				return true;
			}
		} else {
			if (key == 'Up') {
				this.prev();
				return true;
			} else if (key == 'Down') {
				this.next();
				return true;
			}
		}
	}

	function _setContentOffset(offset) {
		this._layout = this._scheduleLayout = function() { } //I LOVE JS
		this.contentX = offset
		delete this._layout
		delete this._scheduleLayout
	}

	function _scroll(currentIndex, oldIndex, delta) {
		var prevItem = this._items[oldIndex]
		var item = this._items[currentIndex]
		if (!item || !item.visibleInView || !prevItem || !prevItem.visibleInView) {
			this._scheduleLayout()
			return
		}
		log('scrolling to ', currentIndex, oldIndex, item.viewX, delta)
		if (item.viewX < 0 || (item.viewX + item.width) > this.width)
			this._scheduleLayout()
		this._setContentOffset(this.contentX + delta * (prevItem.width + this.spacing))
	}

	onOrientationChanged: { this._scheduleLayout() }

	onCurrentIndexChanged: {
		var oldIndex = this._oldIndex
		if (value !== oldIndex) {
			var n = this._items.length
			var m = n / 2
			var delta = value - oldIndex
			if (delta > m)
				delta = delta - n
			if (delta < -m)
				delta = delta + n

			//log('currentIndexChanged', value, oldIndex, delta)
			this._scroll(value, oldIndex, delta)
			this._oldIndex = value
		}
	}
}
