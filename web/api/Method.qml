Object {
	property string type: "GET";
	property string name;
	property string path;

	function call(api, args) {
		var nargs = this.args.length
		if (args.length < nargs + 2)
			throw new Error("not enough arguments for method " + this.name)

		var argsargs 	= Array.prototype.slice.call(args, 0, nargs)
		var data 		= this.args.apply(this, argsargs)
		var callback 	= args[nargs + 0]
		var error 		= args[nargs + 1]

		api.call(this.path, callback, error, this.type, data) //fixme: add headers
	}

	function args() {
	}

	onTypeChanged,
	onNameChanged,
	onPathChanged: {
		this.parent._registerMethod(this.name, this)
	}
}
