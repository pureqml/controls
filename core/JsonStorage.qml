///LocalStorage wrapper with signals and simple interface
LocalStorage {
	signal loaded;			///< json was loaded
	signal optionUpdated;	///< option changed signal

	/// load JSON method
	load: {
		this.read()
		this.loaded()
	}

	/**@param name:string property name
	returns JSON propeprty value by name*/
	getValue(name): {
		var value = this.getItem(name)
		try { return value && JSON.parse(value) }
		catch (e) { if (e.name != 'SyntaxError') throw e }
		return value
	}

	/**@param name:string property name
	@param value:Object property value
	save JSON property 'name' with value 'value'*/
	setValue(name, value): {
		this.name = name
		this.value = JSON.stringify(value)
		this.optionUpdated(name, value)
	}

	///@private
	onCompleted: { this.load() }
}
