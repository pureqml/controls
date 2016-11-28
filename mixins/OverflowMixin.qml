Object {
	property enum value { Visible, Hidden, Scroll, ScrollX, ScrollY };

	/// @internal
	function _update (name, value) {
		switch(value) {
			case this.Visible:	
				this.parent.style('overflow', 'visible');
				break;
			case this.Hidden:	
				this.parent.style('overflow', 'hidden');
				break;
			case this.Scroll:	
				this.parent.style('overflow', 'scroll');
				break;
			case this.ScrollX:
				this.parent.style('overflow-x', 'scroll');
				this.parent.style('overflow-y', 'hidden');
				break;
			case this.ScrollY:
				this.parent.style('overflow-y', 'scroll');
				this.parent.style('overflow-x', 'hidden');
				break;
		}
		_globals.core.Object.prototype._update.apply(this, arguments);
	}
}
