/// Object for getting remote resources
Request {
	property string url;	///<resource URL
	property string data;	///<uploaded from URL data
	signal error;			///<error signal

	/// @private
	onUrlChanged: {
		var self = this
		this.ajax({
			url: value,
			done: function(data) { self.data = data.target.responseText },
			error: function(err) { self.error(err) }
		})
	}
}
