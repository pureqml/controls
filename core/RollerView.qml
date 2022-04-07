BaseView {
	property enum orientation { Vertical, Horizontal }: Horizontal; //vertical was not widely tested
	content.cssDelegateAlwaysVisibleOnAcceleratedSurfaces: false;

	constructor: {
		this._oldIndex = 0
		this._nextDelta = 0
	}

	/// @private
	function positionViewAtIndex(idx) { }

	/// @private
	function _getCurrentIndex(adj) {
		var n = this._items.length
		if (adj === undefined)
			adj = 0
		return (((this.currentIndex + adj) % n) + n) % n
	}

	/// @private creates delegate in given item slot
	function _createDelegate(idx) {
		var item = _globals.core.BaseView.prototype._createDelegate.apply(this, arguments)
		if (this.orientation === this.Horizontal)
			item.onChanged('width', this._scheduleLayout.bind(this))
		else
			item.onChanged('height', this._scheduleLayout.bind(this))
		return item
	}

	/// @private
	function _layout(noPrerender) {
		var model = this._modelAttached;
		if (!model)
			return

		this.count = model.count

		if (!this.recursiveVisible && !this.offlineLayout) {
			this.layoutFinished()
			return
		}

		var horizontal = this.orientation === this.Horizontal
		var items = this._items

		if (!items.length || !this.count) {
			this.layoutFinished()
			return
		}

		var view = this
		var w = this.width
		var h = this.height
		var created = false
		var size = horizontal ? w : h
		var n = items.length
		var currentIndex = this._getCurrentIndex()
		var spacing = this.spacing

		var positionMode = this.positionMode

		var currentItem = this._createDelegate(currentIndex)
		var currentItemSize = horizontal? currentItem.width: currentItem.height

		var prerender = noPrerender? 0: this.prerender * size
		var leftViewMargin = -currentItemSize
		var rightViewMargin = size + currentItemSize
		var leftMargin = leftViewMargin - prerender
		var rightMargin = rightViewMargin + prerender

		var pos
		switch(positionMode) {
			case this.Beginning:
				pos = 0
				break
			case this.End:
				pos = size - currentItemSize
				break
			default:
				//log('unsupported position mode ' + positionMode)
			case this.Center:
				pos = (size - currentItemSize) / 2
				break
		}

		if (horizontal)
			currentItem.viewX = pos
		else
			currentItem.viewY = pos

		if (this.trace)
			log("layout " + n + " into " + w + "x" + h + " @ " + this.content.x + "," + this.content.y + ", prerender: " + prerender + ", range: " + leftMargin + ":" + rightMargin)

		for(var i = 0; i < n; ++i) {
			var item = items[i]
			if (item)
				item.__rendered = false
		}

		var leftInPrerender = true, rightInPrerender = true, leftInView = true, rightInView = true
		var prevRight = pos, prevLeft = pos
		var nextLeftIndex = -1, nextRightIndex = 0

		var positionItem = function(idx, item, itemPos) {
			item.visibleInView = true
			if (horizontal)
				item.viewX = itemPos
			else
				item.viewY = itemPos

			if (currentIndex == idx && !item.focused) {
				view.focusChild(item)
				if (view.contentFollowsCurrentItem)
					view.positionViewAtIndex(i)
			}
		}

		var positionLeft = function() {
			var idx = view._getCurrentIndex(nextLeftIndex)
			var item = view._createDelegate(idx)
			if (item.__rendered)
				return false

			--nextLeftIndex

			var itemSize = horizontal? item.width: item.height
			var itemPos = prevLeft - spacing - itemSize

			if (itemPos + itemSize <= leftMargin)
				leftInPrerender = false
			if (itemPos + itemSize <= leftViewMargin)
				leftInView = false
			prevLeft = itemPos
			item.__rendered = true
			positionItem(idx, item, itemPos)
			if (view.trace)
				log('positioned (left) ', idx, 'at', itemPos)
			return true
		}

		var positionRight = function() {
			var idx = view._getCurrentIndex(nextRightIndex)
			var item = view._createDelegate(idx)
			if (item.__rendered)
				return false

			++nextRightIndex

			var itemSize = horizontal? item.width: item.height
			var itemPos = prevRight

			if (itemPos >= rightMargin)
				rightInPrerender = false
			if (itemPos >= rightViewMargin)
				rightInView = false
			prevRight = itemPos + itemSize + spacing
			item.__rendered = true
			positionItem(idx, item, itemPos)
			if (view.trace)
				log('positioned (right) ', idx, 'at', itemPos)
			return true
		}

		positionRight() //first element

		while(leftInView || rightInView) {
			if (leftInView && !positionLeft())
				leftInView = false
			if (rightInView && !positionRight())
					rightInView = false
		}

		while(leftInPrerender || rightInPrerender) {
			if (leftInPrerender && !positionLeft())
				leftInPrerender = false
			if (rightInPrerender && !positionRight())
					rightInPrerender = false
		}

		for(var i = 0; i < n; ++i) {
			var item = items[i]
			if (item && !item.__rendered)
				item.visibleInView = false
		}


		var nextDelta = this._nextDelta
		this._nextDelta = 0
		if (nextDelta !== 0) {
			//disable animation
			var animationDuration = this.animationDuration
			this.animationDuration = 0
			//set offset without layout
			this._setContentOffset(-nextDelta)

			//update everything
			this.content.element.forceLayout()
			//enable animation
			this.animationDuration = animationDuration
			//simulate animation to 0
			this._setContentOffset(0)
		}
		this._context.scheduleComplete()
	}

	/// @private
	function next() {
		var n = this._items.length
		if (n > 1)
			this.currentIndex = this._getCurrentIndex(1)
	}

	/// @private
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

	/// @private
	function _setContentOffset(offset) {
		this._layout = this._scheduleLayout = function() { } //I LOVE JS
		if (this.orientation === this.Horizontal)
			this.contentX = offset
		else
			this.contentY = offset
		delete this._layout
		delete this._scheduleLayout
	}

	/// @private
	function _scroll(currentIndex, oldIndex, delta) {
		var prevItem = this._items[oldIndex]
		var item = this._items[currentIndex]
		if (!item || !item.visibleInView || !prevItem || !prevItem.visibleInView) {
			this._scheduleLayout()
			return
		}

		var horizontal = this.orientation === this.Horizontal
		//log('scrolling to ', currentIndex, oldIndex, item.viewX, delta)

		//fixme: allow less frequent layouts
		//if (item.viewX < 0 || (item.viewX + item.width) > this.width)
			this._scheduleLayout()
		//else
		//	this._setContentOffset(this.contentX + this._nextDelta)

		this._nextDelta = delta * ((horizontal? prevItem.width: prevItem.height) + this.spacing)
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
