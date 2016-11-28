Object {
	/// @internal
	function _update (name, value) {
		this.parent.style(name, value);
		_globals.core.Object.prototype._update.apply(this, arguments);
	}
}