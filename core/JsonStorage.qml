///LocalStorage wrapper with signals and simple interface
LocalStorage {
	signal loaded;			///< json was loaded
	signal optionUpdated;	///< option changed signal

	/**
	 * Returns JSON propeprty value by name
	 * @param {string} name - property name
	 * @param {function} callback - callback to return value
	 * @param {function} error - callback to report non-existing value or some kind of error
	 */
	getValue(name, callback, error): {
		callback = this._ensureCallback(callback, name)
		error = this._ensureErrCallback(error)
		this.get(name, function(value) {
			try { callback(JSON.parse(value)) }
			catch (err) { error(err) }
		}, error)
	}

	/**
	 * Returns JSON propeprty value by name or default value if not exists
	 * @param {string} name - property name
	 * @param {function} callback - callback to return value
	 * @param {Object} defaultValue - default value
	 */
	getValueOrDefault(name, callback, defaultValue): {
		callback = this._ensureCallback(callback, name)
		this.getOrDefault(name, function(value) {
			try { callback(JSON.parse(value)) }
			catch (err) { callback(defaultValue) }
		}, defaultValue)
	}

	/**
	 * Save named JSON property
	 * @param {string} name - property name
	 * @param {Object} value - property value
	 * @param {function} error - callback to report error
	 */
	setValue(name, value, error): {
		this.set(name, JSON.stringify(value), error)
		this.optionUpdated(name, value)
	}

	/**
	 * Remove property from storage
	 * @param {string} name - property name
	 * @param {function} error - callback to report error
	 */
	eraseValue(name, error): {
		this.erase(name, error)
	}

	///@private
	onCompleted: { this.loaded() }
}
