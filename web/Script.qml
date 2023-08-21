Item {
	property string source; ///< source to load script from

	signal loaded; ///< signal emitted when script loaded

	constructor: {
		this.element.setAttribute('type', 'text/javascript')
		this._onLoad = this._context.wrapNativeCallback(function() {
			this._loaded = true
			this.loaded();
		}.bind(this))
		this._loaded = false
		this.element.dom.addEventListener('load', this._onLoad)
	}

	function on (name, callback) {
		_globals.core.Item.prototype.on.call(this, name, callback)
		if (this._loaded && name === 'loaded')
			callback()
	}

	///@private
	function discard() {
		this._loaded = false
		this.element.dom.removeEventListener('load', this._onLoad)
		_globals.core.Item.prototype.discard.call(this)
	}

	/// @private
	function _delayedLoad() {
		this._context.delayedAction('script:load', this, this.load)
	}

	function load() {
		this._loaded = false
		var source = this.source
		if (!source)
			return

		log('loading script from ' + source)

		this.element.setAttribute('src', source)
	}

	onSourceChanged:	{ this._delayedLoad() }
	onCompleted:		{ this._delayedLoad() }

	htmlTag: "script";
}
