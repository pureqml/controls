BaseView {
	property enum orientation { Vertical, Horizontal };

	constructor: {
		this._oldIndex = 0
		this._nextDelta = 0
	}

	function positionViewAtIndex(idx) { }

	function _getCurrentIndex(adj) {
		var n = this._items.length
		if (adj === undefined)
			adj = 0
		return (((this.currentIndex + adj) % n) + n) % n
	}

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
		var n = items.length
		var currentIndex = this._getCurrentIndex()
		var spacing = this.spacing

		var prerender = this.prerender * size
		var leftMargin = -prerender
		var rightMargin = size + prerender
		var positionMode = this.positionMode

		var currentItem = this._createDelegate(currentIndex)

		var pos
		switch(positionMode) {
			case this.Beginning:
				pos = 0
				break
			case this.End:
				pos = size - currentItem.width
				break
			default:
				//log('unsupported position mode ' + positionMode)
			case this.Center:
				pos = (size - currentItem.width) / 2
				break
		}
		currentItem.viewX = pos

		var leftIn = true, rightIn = true
		for(var i = 0; i < 2 * n && (leftIn || rightIn); ++i) {
			var di = (i & 1)? ((1 - i) / 2 - 1): i / 2
			var idx = this._getCurrentIndex(di)
			var item = this._createDelegate(idx)
			var itemPos
			if (di < 0) {
				var next = this._createDelegate(this._getCurrentIndex(di + 1))
				itemPos = next.viewX - spacing - item.width
				if (itemPos < leftMargin)
					leftIn = false
			} else if (di > 0) {
				var prev = this._createDelegate(this._getCurrentIndex(di - 1))
				itemPos = prev.viewX + prev.width + spacing
				if (itemPos >= rightMargin)
					rightIn = false
			} else //currentIndex 0
				itemPos = pos
			//log(idx, itemPos)

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
			var idx = this._getCurrentIndex(di)
			var item = items[idx]
			if (item)
				item.visibleInView = false
		}
		var nextDelta = this._nextDelta
		this._nextDelta = 0
		if (nextDelta === 0)
			return

		//disable animation
		var animationDuration = this.animationDuration
		this.animationDuration = 0
		//set offset without layout
		this._setContentOffset(-nextDelta)
		this.content.element.updateStyle()

		//update everything
		this.element.forceLayout()
		//enable animation
		this.animationDuration = animationDuration
		//simulate animation to 0
		this._setContentOffset(0)
	}

	function next() {
		var n = this._items.length
		if (n > 1)
			this.currentIndex = this._getCurrentIndex(1)
	}

	function prev() {
		var n = this._items.length
		if (n > 1)
			this.currentIndex = this._getCurrentIndex(-1)
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
		//log('scrolling to ', currentIndex, oldIndex, item.viewX, delta)

		//fixme: allow less frequent layouts
		//if (item.viewX < 0 || (item.viewX + item.width) > this.width)
			this._scheduleLayout()
		//else
		//	this._setContentOffset(this.contentX + this._nextDelta)

		this._nextDelta = delta * (prevItem.width + this.spacing)
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
