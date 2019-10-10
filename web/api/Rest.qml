Object {
	Request { id: apiRequest; }

	function addChild(child) {
		if ($controls && $controls['web'] && $controls['web']['api'] && $controls['web']['api']['Endpoint'] && (child instanceof $controls$web$api$Endpoint)) {
			var name = child.name
			if (name) {
				this[name] = function() {
					log(name, arguments)
				}
			} else {
				log("skipping method with no name")
			}
		}
		$core.Object.prototype.addChild.apply(this)
	}
}
