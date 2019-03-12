Item {
	property string source; ///< source to load script from

	property bool loaded; ///< script was loaded

	constructor: {
		this.element.dom.setAttribute('type', 'text/javascript')
		this._onLoad = this._context.wrapNativeCallback(function() { this.loaded = true }.bind(this))
		this.element.dom.addEventListener('load', this._onLoad)
	}

	///@private
	function discard() {
		this.loaded = false;
		this.removeEventListener('load', this._onLoad)
		_globals.core.Item.prototype.discard.call(this)
	}

	/// @private
	function _delayedLoad() {
		this._context.delayedAction('script:load', this, this.load)
	}

	function load() {
		this.loaded = false
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
