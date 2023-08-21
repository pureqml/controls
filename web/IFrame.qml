/// iframe item to embed other page
Item {
	signal loaded;				///< page was loaded signal
	property string source;		///< another page source URL
	property string origin;		///< readonly property of source's origin for message matching
	signal message;				///< message from window opened in this IFrame

	htmlTag: "iframe";

	function postMessage(data) {
		this.element.dom.contentWindow.postMessage(data, this.source)
	}

	context.onMessage(event): {
		if (event.origin !== this.origin) //not ours
			return

		log('IFrame: incoming message from ' + event.origin)
		this.message(event)
	}

	onSourceChanged: {
		this.origin = new URL(value).origin
		this.element.dom.src = value;
	}

	constructor: {
		var self = this
		this.element.on('load', function() { self.source = this.dom.src; self.loaded() })
	}
}
