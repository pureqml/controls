BaseView {
	property enum orientation { Vertical, Horizontal };
	property bool cacheEnable: true;

	constructor: {
		this._offset = 0
	}

	function _onReset() {
		var model = this.model
		if (this.trace)
			log("rollerview reset", this._items.length, model.count)

		this._offset = 0
		this._modelUpdate.reset(model)
		this._scheduleLayout()
	}

	function positionViewAtIndex(idx) { }

	function _processUpdates() {
		this._modelUpdate.apply(this, true) //do not check _items count in apply
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
		var ci = this.currentIndex

		//HAX!
		var diff = (ci + this._offset - 3) - (ci < this.count - 3 ? 0 : 2)
		var currItem = items[ci + this._offset]

		if (diff > 0) {
			for (var i = 0; i <= diff; ++i) {
				var item = items[i]
				if (item)
					item.discard()
			}
			this._items.splice(0, diff);
			this._offset = 3 - ci

			for (var i = items.length; i < this.count; ++i)
				this._items.push(null)
		}

		if (diff == -3) {
			for (var i = items.length + diff; i < items.length; ++i) {
				var item = items[i]
				if (item)
					item.discard()
				this._items[i] = null
			}
			this._offset = 0
		}

		if (items[ci + this._offset] != currItem) {
			var currIdx
			for (var i = 0; i < items.length; ++i)
				if (items[i] == currItem)
					currIdx = i - ci
			diff = ci + this._offset - currIdx
			diff = diff == 3 ? 5 : (diff == 5 ? 3 : diff)
			for (var i = 0; i <= diff; ++i) {
				var item = items[i]
				if (item)
					item.discard()
				item = null
			}
			this._items.splice(0, diff);
		}

		var item = items[ci + this._offset]
		if (!item) {
			item = this._createDelegate(ci)
			created = true
		}

		var itemSize = horizontal ? item.width : item.height
		var posBefore = 0
		switch (this.positionMode)
		{
			case this.Center:
				posBefore = (size - itemSize) / 2
				break
			case this.End:
				posBefore = size - itemSize
				break
			default:
				posBefore = this.x
				break
		}
		var posAfter = posBefore + itemSize + this.spacing

		if (horizontal)
			item.viewX = posBefore
		else
			item.viewY = posBefore

		if (this.trace)
			log("current item", ci, posBefore)

		var renderedBefore,
			renderedAfter,
			plusOne = this.cacheEnable;

		for (var i = ci - 1; posBefore > 0 || plusOne; --i) {
			var item = items[i + this._offset]

			if (!item) {
				item = this._createDelegate(i)
				created = true
			}

			var s = (horizontal ? item.width : item.height)

			if (posBefore <= 0)
				plusOne = false

			posBefore -= s + this.spacing

			if (horizontal)
				item.viewX = posBefore
			else
				item.viewY = posBefore

			if (this.trace)
				log("item before", i, posBefore)

			item.visible = true
			renderedBefore = i + this._offset
		}

		plusOne = this.cacheEnable;

		for (var i = ci + 1; posAfter < size || plusOne; ++i) {
			var item = items[i + this._offset]

			if (!item) {
				item = this._createDelegate(i)
				created = true
			}

			var s = (horizontal ? item.width : item.height)

			if (horizontal)
				item.viewX = posAfter
			else
				item.viewY = posAfter

			if (posAfter >= s)
				plusOne = false

			if (this.trace)
				log("item after", i, posAfter, s)
			posAfter += s + this.spacing
			item.visible = true
			renderedAfter = i + this._offset + 1
		}

		if (this.trace)
			log("before", renderedBefore, "afer", renderedAfter)

		for (var i = 0; i < this._items.length - renderedAfter; ++i) {
			if (this.trace)
				log("trying to remove from the end", i)
			var item = items.pop()
			if (item)
				item.discard()
		}

		for (var i = 0; i < renderedBefore; ++i) {
			if (this.trace)
				log("trying to remove from the beginning", i)
			var item = items.shift()
			if (item) {
				this._offset--
				item.discard()
			}
		}

		this._items.splice(0, renderedBefore - 1);

		this.layoutFinished()
		if (created)
			this._context._complete()
	}

	/// @internal focuses current item
	function focusCurrent() { }

	/// @internal creates delegate in given item slot
	function _createDelegate(idx) {
		if (this.trace)
			log("create", idx)
		var mapped = idx < 0 ? mapped = (this.count + (idx % this.count)) % this.count : (idx % this.count)

		if (this.trace)
			log("mapped", mapped)
		var row = this.model.get(mapped)
		row['index'] = idx
		this._local['model'] = row
		var item = this.delegate(this)

		if (idx + this._offset >= 0)
			this._items[idx + this._offset] = item
		else {
			this._items.unshift(item)
			this._offset++
		}

		if (this.trace)
			log("_createDelegate", idx, mapped, this._offset)
		item.view = this
		this.element.append(item.element)
		item._local['model'] = row
		if (this.orientation === this.Horizontal)
			item.onChanged('width', this._scheduleLayout.bind(this))
		else
			item.onChanged('height', this._scheduleLayout.bind(this))

		delete this._local['model']
		return item
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
	onCurrentIndexChanged: { this._scheduleLayout() }
}
