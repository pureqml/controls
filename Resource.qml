Protocol {
	property string data;

	onUrlChanged: {
		var self = this
		this.request(value, function(data) { self.data = data })
	}
}
