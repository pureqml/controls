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
		return this._storage.getItem(this.name)
	}

	/**@param name:string property name
	@param value:Object property value
	save JSON property 'name' with value 'value'*/
	setValue(name, value): {
		this.name = name
		this.init()
		this._storage.setItem(name, value)
		this.optionUpdated(name, value)
	}

	///@private
	onCompleted: { this.load() }
}
