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
	returns JSON proeprty value by name*/
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
