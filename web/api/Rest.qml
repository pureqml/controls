/**
	Root component for REST API declaration.
	Normally Rest component contains one or more Method instances.
	<pre>
		Rest {
			id: api;
			baseUrl: "https://example.com/v1";

			function headers(headers) { headers.token = 'secret'; }

			Method { name: "getList"; path: "list/{name}"; }
		}
		//in js:
		api.getList(name, function() {...}, function () { ... })
	</pre>
*/


Object {
	Request { id: apiRequest; } ///< Request object used for ajax requests

	property string baseUrl; ///< base url for all requests

	signal error; ///< all errors signalled here
	signal internetConnectionLost; ///< some platforms signal when internet connection lost, see onError
	property int activeRequests; ///< number of currently running requests.

	constructor: {
		this._methods = {}
	}

	onError(url, method, response): {
		if ((typeof window !== 'undefined' && !window.navigator.onLine) || response && response.target && response.target.status === 0 && response.target.response === "") {
			this.internetConnectionLost({ "url": url, "method": method, "response": response })
		}
	}

	/// args function allows to override arguments for all methods, e.g. adding session token
	function args(args) {
		return args
	}

	/// headers function allows to override headers for all methods, e.g. adding session token
	function headers(headers) {
	}

	/// @private calls invokes args, headers and ajax, then processes result
	function _call(name, callback, error, method, data, head) {
		var headers = head || {}

		if (data) {
			data = this.args(data)
			headers["Content-Type"] = "application/json"
		}

		var newHeaders = this.headers(headers)
		if (newHeaders !== undefined)
			headers = newHeaders

		++this.activeRequests
		var url = name
		var self = this

		apiRequest.ajax({
			method: method || "GET",
			headers: headers,
			contentType: 'application/json',
			url: url,
			data: data,
			done: function(res) {
				--self.activeRequests
				if (res.target && res.target.status >= 400) {
					log("Error in request", res)
					if (error)
						error(res)
					self.error({"url": url, "method": method, "response": res})
					return
				}

				var text = res.target.responseText
				if (!text) {
					callback("")
					return
				}
				var res
				try {
					res = JSON.parse(text)
				} catch (e) {
					res = text
				}
				callback(res)
			},
			error: function(res) {
				--self.activeRequests
				if (error)
					error(res)
				self.error({"url": url, "method": method, "response": res})
			}
		})
	}

	/// @internal top-level call implementation
	function call(name, callback, error, method, data, head) {
		if (name.indexOf('://') < 0) {
			var baseUrl = this.baseUrl
			if (baseUrl[baseUrl.length - 1] === '/' || name[0] === '/')
				name = baseUrl + name
			else
				name = baseUrl + '/' + name
		}
		this._call(name, callback, error, method, JSON.stringify(data), head)
	}

	/// @private method registration
	function _registerMethod(name, method) {
		if (!name)
			return

		var api = this
		this[name] = function() {
			method.call(api, arguments)
		}
	}
}
