Item {
	property string source; ///< source to load script from

	constructor: {
		this.element.dom.setAttribute('type', 'text/javascript')
	} 

	/// @private
	function _delayedLoad() {
		this._context.delayedAction('script:load', this, this.load())
	}

	function load() {
		var source = this.source
		if (!source)
			return

		log('loading script from ' + source)

		this.element.dom.setAttribute('src', source)
	}

	onSourceChanged:	{ this._delayedLoad() }
	onCompleted:		{ this._delayedLoad() }

	function getTag() { return 'script' }
}
