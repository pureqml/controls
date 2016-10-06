LocalStorage {
	signal saved;
	signal loaded;
	signal optionUpdated;

	load: {
		this.read()
		this.loaded()
	}

	getValue(name): {
		this.name = name
		var res
		try {
			res = JSON.parse(this.value)
		} catch(e) {
			res = this.value
		}
		return res
	}

	setValue(name, value): {
		this.name = name
		this.value = JSON.stringify(value)
		this.optionUpdated(name, value)
	}

	onCompleted: { this.load() }
}
