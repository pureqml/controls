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
		return this.value && (typeof this.value === "object") ? JSON.parse(this.value) : this.value
	}

	setValue(name, value): {
		this.name = name
		this.value = JSON.stringify(value)
		this.optionUpdated(name, value)
	}

	onCompleted: { this.load() }
}
