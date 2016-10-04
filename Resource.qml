Protocol {
	property string data;

	onUrlChanged: {
		var self = this
		this.requestXHR({
			"url": value,
			"callback": function(data) { self.data = data.target.responseText }
		})
	}
}
