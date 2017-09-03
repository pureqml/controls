/// iframe item to embed other page
Item {
	signal loaded;				///< page was loaded signal
	property string source;		///< another page source URL

	///@private
	function getTag() { return 'iframe' }

	onSourceChanged: { this.element.dom.src = value; }

	constructor: {
		var self = this
		this.element.on('load', function() { self.source = this.src; self.loaded() })
	}
}
