///setup parents overflow mode
BaseMixin {
	property enum value { Visible, Hidden, Scroll, ScrollX, ScrollY };	///< overflow mode value, can be:  Visible, Hidden, Scroll, ScrollX, ScrollY

	/// @internal
	_updateOverflow(value): {
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
	}
	onValueChanged: { this._updateOverflow(value) }
	onCompleted: { this._updateOverflow(this.value) }
}
