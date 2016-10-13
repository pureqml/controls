Item {

	// Add to context.
			//"ul { position: absolute; visibility: inherit; margin: 0px;" +
				//window.Modernizr.prefixedCSS('margin-before') + ": 0px; " + 
				//window.Modernizr.prefixedCSS('padding-start') + ": 0px; " +
				//"}" +
	// EXPEREMENTAL CONTROL! MUCH DANGEROUS!
	property Object model;
	property Item delegate;
	property int count;
	property int currentIndex;
	property int contentWidth: 1;
	property int contentHeight: 1;

	constructor: {
		this._items = []

		this.element.remove()
		this.element = $(this._context.createElement('ul'))
		this.parent.element.append(this.element)
		this.style('list-style-type', 'none')
		this.style('white-space', 'normal')
	}

	//TODO: Impl
	function _onReset() { }
	function _onRowsChanged(begin, end) { }
	function _onRowsRemoved(begin, end) { }

	function _onRowsInserted(begin, end) {
		for (var i = begin; i < end; ++i)
			this._createDelegate(i)
	}

	function _createDelegate(idx) {
		if (!this.model)
			return
		var li = $(this._context.createElement('li'))
		var row = this.model.get(idx)
		this._local['model'] = row
		var del = this.delegate()
		del.style('position', 'relative')
		del.element.remove()
		li.append(del.element)
		del._local['model'] = row
		this.element.append(li)
		//li[0].style.display = 'inline' //TODO: vertica/horizontal layout
		li[0].style.display = 'inline-block'
		delete this._local['model']
	}

	function _update(name, value) {
		switch(name) {
		case 'delegate':
			if (value)
				value.visible = false
			break
		}
		_globals.core.Item.prototype._update.apply(this, arguments);
	}

	function _attach() {
		if (this._attached || !this.model || !this.delegate)
			return

		this.model.on('reset', this._onReset.bind(this))
		this.model.on('rowsInserted', this._onRowsInserted.bind(this))
		//this.model.on('rowsChanged', this._onRowsChanged.bind(this))
		//this.model.on('rowsRemoved', this._onRowsRemoved.bind(this))
		this._attached = true
		this._onReset()
	}

	onCompleted: { this._attach() }
}
