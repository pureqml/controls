///setup parents overflow mode
Object {
	property enum value { Visible, Hidden, Scroll, ScrollX, ScrollY };	///< overflow mode value, can be:  Visible, Hidden, Scroll, ScrollX, ScrollY

	/// @internal
	onValueChanged: {
		switch(value) {
			case this.Visible:
				this.parent.style('overflow', 'visible');
				break;
			case this.Hidden:
				this.parent.style('overflow', 'hidden');
				break;
			case this.Scroll:
				this.parent.style('overflow', 'auto');
				break;
			case this.ScrollX:
				this.parent.style('overflow', 'auto');
				this.parent.style('overflow-y', 'hidden');
				break;
			case this.ScrollY:
				this.parent.style('overflow', 'auto');
				this.parent.style('overflow-x', 'hidden');
				break;
		}
		_globals.core.Object.prototype._update.apply(this, arguments);
	}
}
