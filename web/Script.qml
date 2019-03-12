Item {
	property string source; ///< source to load script from

	signal loaded; ///< signal emitted when script loaded

	constructor: {
		this.element.dom.setAttribute('type', 'text/javascript')
		this._onLoad = this.loaded.bind(this)
		this.element.dom.addEventListener('load', this._onLoad)
	}

	///@private
	function discard() {
		this.removeEventListener('load', this._onLoad)
		_globals.core.Item.prototype.discard.call(this)
	}

	/// @private
	function _delayedLoad() {
		this._context.delayedAction('script:load', this, this.load)
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
