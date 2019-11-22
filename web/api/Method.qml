Object {
	property string type: "GET";
	property string name;
	property string path;

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

	function headers(headers) {
	}

	function args() {
	}

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
