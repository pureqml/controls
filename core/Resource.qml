/// Object for getting remote resources
Protocol {
	property string url;	///<resource URL
	property string data;	///<uploaded from URL data

	/// @private
	onUrlChanged: {
		var self = this
		this.requestXHR({
			"url": value,
			"callback": function(data) { self.data = data.target.responseText }
		})
	}
}
