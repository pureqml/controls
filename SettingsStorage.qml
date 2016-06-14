LocalStorage {
	signal saved;
	signal loaded;
	property variant innerSettings;

	load: {
		this.read();
		this.innerSettings = this.value ? JSON.parse(this.value) : 0
		this.loaded()
	}

	save: { this.value = JSON.stringify(this.innerSettings); this.saved() }

	getValue(name): { return this.innerSettings[name] }

	setValue(name, value): {
		if (!this.innerSettings)
			this.innerSettings = {}
		this.innerSettings[name] = value
		this.save()
	}

	onCompleted: { this.load() }
}
