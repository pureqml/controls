Object {
	signal error;
	signal closed;
	signal message;
	property bool connected;
	property bool emulateKeyPressing: true;
	property string ip;
	property string port;
	property string host: "ws://" + ip + ":" + port;

	pressKey(key): {
		var keyCode = _globals.core.getKeyCodeByName(key)
		if (keyCode) {
			var event = { keyCode : keyCode , timeStamp: new Date().getTime() }
			this.parent._context.processKey(event)
		}
	}

	send(msg): {
		log("send:", this.connected, "socket", this._socket)
		if (this.connected)
			this._socket.send(msg)
	}

	connect: {
		if (!this.ip || !this.port) {
			log("Failed to connect port:", this.port, "ip:", this.ip)
			return
		}

		log("Create socket for host:", this.host)
		var socket = new WebSocket(this.host)
		log("socket created", socket)
		var context = this._context
		log("context")
		var self = this
		log("self")

		socket.onopen = context.wrapNativeCallback(function() {
			log("Sonnection opened")
			self.connected = true
		})

		socket.onclose = context.wrapNativeCallback(function(event) {
			log('Connection was closed. Code:', event.code, 'reason:', event.reason, "wasClean:", event.wasClean)
			self.connected = false
		})

		socket.onerror = context.wrapNativeCallback(function(error) {
			log("Connection error:", error.message)
		})

		socket.onmessage = context.wrapNativeCallback(function(event) {
			var data = JSON.parse(event.data)
			if (self.emulateKeyPressing && data && data.key)
				self.pressKey(data.key)
			self.message(data)
		})

		log("configured")
	}
}
