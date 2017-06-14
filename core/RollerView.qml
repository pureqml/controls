BaseView {
	property enum orientation { Vertical, Horizontal };
	property bool cacheEnable: true;

	constructor: {
		this._offset = 0
	}

	function positionViewAtIndex(idx) {
	}

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

		if (!items.length) {
			this.layoutFinished()
			return
		}

		var w = this.width
		var h = this.height
		var created = false
		var size = horizontal ? w : h
		var ci = this.currentIndex
		var item = items[ci + this._offset]

		if (!item) {
			item = this._createDelegate(ci)
			created = true
		}

		var itemSize = horizontal ? item.width : item.height
		var pb = (size - itemSize) / 2
		var pf = pb + itemSize + this.spacing

		if (horizontal)
			item.viewX = pb
		else
			item.viewY = pb

		if (this.trace)
			log("current item", ci, pb)

		var renderedBefore,
			renderedAfter,
			plusOne = this.cacheEnable;

		for (var i = ci - 1; pb > 0 || plusOne; --i) {
			var item = items[i + this._offset]

			if (!item) {
				item = this._createDelegate(i)
				created = true
			}

			var s = (horizontal ? item.width : item.height)

			if (pb <= 0)
				plusOne = false

			pb -= s + this.spacing

			if (horizontal)
				item.viewX = pb
			else
				item.viewY = pb

			if (this.trace)
				log("item before", i, pb)

			item.visible = true
			renderedBefore = i + this._offset
		}

		plusOne = this.cacheEnable;

		for (var i = ci + 1; pf < size || plusOne; ++i) {
			var item = items[i + this._offset]

			if (!item) {
				item = this._createDelegate(i)
				created = true
			}

			var s = (horizontal ? item.width : item.height)

			if (horizontal)
				item.viewX = pf
			else
				item.viewY = pf

			if (pf >= s)
				plusOne = false

			if (this.trace)
				log("item after", i, pf, s)
			pf += s + this.spacing
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
	function focusCurrent() {
	}

	/// @internal creates delegate in given item slot
	function _createDelegate(idx) {
		if (this.trace)
			log("create", idx)
		var mapped
		if (idx < 0)
			mapped = (this.count + (idx % this.count)) % this.count
		else
			mapped = idx % this.count

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
		var delayedLayout = this._delayedLayout
		if (this.orientation === this.Horizontal)
			item.onChanged('width', delayedLayout.schedule.bind(delayedLayout))
		else
			item.onChanged('height', delayedLayout.schedule.bind(delayedLayout))

		delete this._local['model']
		return item
	}

	onKeyPressed: {
		if (!this.handleNavigationKeys) {
			event.accepted = false;
			return false;
		}

		var horizontal = this.orientation == this.Horizontal
		if (horizontal) {
			if (key == 'Left') {
				--this.currentIndex;
				event.accepted = true;
				return true;
			} else if (key == 'Right') {
				++this.currentIndex;
				event.accepted = true;
				return true;
			}
		} else {
			if (key == 'Up') {
				if (!this.currentIndex && !this.keyNavigationWraps) {
					event.accepted = false;
					return false;
				}
				--this.currentIndex;
				return true;
			} else if (key == 'Down') {
				if (this.currentIndex == this.count - 1 && !this.keyNavigationWraps) {
					event.accepted = false;
					return false;
				}
				++this.currentIndex;
				event.accepted = true;
				return true;
			}
		}
	}

	onOrientationChanged: { this._delayedLayout.schedule() }
	onCurrentIndexChanged: { this._delayedLayout.schedule() }
}
