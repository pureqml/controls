/// Object for getting remote resources
Request {
	property string url;	///<resource URL
	property string data;	///<uploaded from URL data
	signal error;			///<error signal

	/// @private
	function load(url) {
		if (url) {
			var self = this
			this.ajax({
				url: url,
				done: function(data) {
					var target = data.target
					if (target.status >= 400)
						self.error(data)
					else
						self.data = target.responseText
				},
				error: function(err) { self.error(err) }
			})
		} else {
			this.data = ''
		}
	}

	onUrlChanged:	{ this.load(value) }
	onCompleted:	{ this.load(this.url) }
}
