Protocol {
	baseUrl: "https://api.vk.com";

	wallGet(callback, settings): { this.vkMethodRequest("wall.get", callback, settings) }
	wallSearch(callback, settings): { this.vkMethodRequest("wall.search", callback, settings) }
	wallGetComments(callback, settings): { this.vkMethodRequest("wall.getComments", callback, settings) }

	vkMethodRequest(method, callback, settings): {
		var query = ""
		for (var i in settings)
			query += (!query ? "?" : "&") + i + "=" + settings[i]

		function jsonp(url, callbackFunc) {
			var callbackName = 'jsonp_callback_' + Math.round(1000000000 * Math.random());
			window[callbackName] = function(data) {
				delete window[callbackName];
				document.body.removeChild(script);
				callbackFunc(data);
			};

			var script = document.createElement('script');
			script.src = url + (url.indexOf('?') >= 0 ? '&' : '?') + 'callback=' + callbackName;
			document.body.appendChild(script);
		}

		jsonp(this.baseUrl + "/method/" + method + query, function(data) {
			callback(data)
		});
	}
}
