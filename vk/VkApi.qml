/// vkontakte API object
Object {
	/**@param callback:function request done callback function
	@param settings:Object additional query params
	call vk API 'wall.get' method function*/
	wallGet(callback, settings): { this.vkMethodRequest("wall.get", callback, settings) }

	/**@param callback:function request done callback function
	@param settings:Object additional query params
	call vk API 'wall.search' method function*/
	wallSearch(callback, settings): { this.vkMethodRequest("wall.search", callback, settings) }

	/**@param callback:function request done callback function
	@param settings:Object additional query params
	call vk API 'wall.getComments' method function*/
	wallGetComments(callback, settings): { this.vkMethodRequest("wall.getComments", callback, settings) }

	/**@param method:string vk API method name
	@param callback:function request done callback function
	@param settings:Object additional query params
	call vk API method function*/
	vkMethodRequest(method, callback, settings): {
		var query = ""
		for (var i in settings)
			query += (!query ? "?" : "&") + i + "=" + settings[i]

		function jsonp(url, callbackFunc) {
			var callbackName = 'jsonp_callback_' + Math.round(1000000000 * Math.random());
			window[callbackName] = function(data) {

				try {
				  delete window[callbackName];
				} catch (e) {
				  window[callbackName] = undefined;
				}

				document.body.removeChild(script);
				callbackFunc(data);
			};

			var script = document.createElement('script');
			script.src = url + (url.indexOf('?') >= 0 ? '&' : '?') + 'callback=' + callbackName;
			document.body.appendChild(script);
		}

		jsonp("https://api.vk.com/method/" + method + query, function(data) {
			callback(data)
		});
	}
}
