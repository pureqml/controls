/**
Declarative REST API method declaration component.
Each instance registered as javascript method with name specified in name property.
You have to override args function if you need to provide json body for your request (normally needed for POST/PUT)

This is to hide specific API details from method arguments.
E.g. if you have login method with name/password, you can specify it as
function args(name, password) { return { username: name, password: password}}
method registered with args functions will have additional arguments, e.g login(name, pass, done, error)
*/
Object {
	property string type: "GET"; ///< method type, could be any of supported HTTP request types
	property string name; ///< method name
	property string path;

	/// @private call implementation
	function call(api, args) {
		var nargs = this.args.length
		if (args.length < nargs + 2)
			throw new Error("not enough arguments for method " + this.name)
		nargs = args.length - 2

		var argsargs 	= Array.prototype.slice.call(args, 0, nargs)
		var data 		= this.args.apply(this, argsargs)
		var callback 	= args[nargs + 0]
		var error 		= args[nargs + 1]
		var headers 	= {}
		var newHeaders  = this.headers(headers)
		if (newHeaders !== undefined)
			headers = newHeaders
		var path = this.pathArgs(this.path, argsargs)

		api.call(path, callback, error, this.type, data, headers)
	}

	/// headers override
	function headers(headers) {
	}

	/// additional arguments provided for method
	function args() {
	}

	/// @internal replace path arguments ({} by default)
	function pathArgs(path, args) {
		var path = this.path
		var re = /\{(\w+)\}/g
		var index = 0
		path = path.replace(re, function(m) {
			return (index < args.length)? args[index++]: ''
		})

		return path
	}

	onNameChanged: {
		this.parent._registerMethod(this.name, this)
	}
}
