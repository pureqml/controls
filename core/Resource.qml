/// Object for getting remote resources
Request {
	property string url;	///<resource URL
	property string data;	///<uploaded from URL data
	signal error;			///<error signal

	function load(url) {
		if (url) {
			var self = this
			this.ajax({
				url: url,
				done: function(data) { self.data = data.target.responseText },
				error: function(err) { self.error(err) }
			})
		} else {
			this.data = ''
		}
	}

	onUrlChanged:	{ this.load(value) }
	onCompleted:	{ this.load(this.url) }
}
