Item {
	property string source; ///< source to load script from

	constructor: {
		this.element.dom.setAttribute('type', 'text/javascript')
		this._delayedLoad = new _globals.core.DelayedAction(this._context, function() {
			this.load()
		}.bind(this))
	} ///< @private

	function load() {
		var source = this.source
		if (!source)
			return

		log('loading script from ' + source)

		this.element.dom.setAttribute('src', source)
	}

	onSourceChanged:	{ this._delayedLoad.schedule() }
	onCompleted:		{ this._delayedLoad.schedule() }

	function getTag() { return 'script' }
}
