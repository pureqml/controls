/// Wrapper for a WebSocket
/// The comments are copied or inspired by https://developer.mozilla.org/en-US/docs/Web/API/WebSocket
Object {
	/// The URL to which to connect; this should be the URL to which the WebSocket server will respond.
	/// The url needs to start with either 'ws://' or 'wss://'
	property string url;

	/// 0 CONNECTING  Socket has been created. The connection is not yet open.
	/// 1 OPEN        The connection is open and ready to communicate.
	/// 2 CLOSING     The connection is in the process of closing.
	/// 3 CLOSED      The connection is closed or couldn't be opened.
	property enum state { Connecting, Open, Closing, Closed }: Closed;

	/// Emitted when a message is received from the server.
	signal message;
	/// Emitted when the state changes to 1 (Open); this indicates that the connection is ready to send and receive data.
	signal opened;
	/// Emitted when the socket was closed, the event has at least the following three members code, reason and wasClean
	signal closed;
	/// Emitted when an error occurs on the WebSocket.
	signal error;

	/// Method enqueues the specified data to be transmitted to the server over the WebSocket connection.
	send(msg): {
		if (this.state == this.Open)
			this._socket.send(msg)
	}

	/// Initiate connect to the provided url
	connect: {
		if (!this.url) {
			this.error("url not set")
			return
		}

		try {
			var socket = new WebSocket(this.url)
			this._socket = socket
			this.state = this.Connecting

			var context = this._context
			var self = this
			socket.onopen = context.wrapNativeCallback(function(event) {
				self.state = self.Open
				self.opened(event);
			})

			socket.onclose = context.wrapNativeCallback(function(event) {
				self.state = self.Closed
				self.closed(event)
			})

			socket.onerror = context.wrapNativeCallback(function(event) {
				self.error(event)
			})

			socket.onmessage = context.wrapNativeCallback(function(event) {
				self.message(event.data)
			})
		} catch(e) {
			this.error("connect error reason: " + e)
		}
	}

	/// Closes the WebSocket connection or connection attempt, if any.
	close: {
		if(!this._socket)
			return;
		this.state = self.Closing
		this._socket.close()
	}

	/// Returns the number of bytes of data that have been queued using calls to send() but not yet transmitted to the network.
	bufferedAmount: {
		return this._socket.bufferedAmount;
	}
}
