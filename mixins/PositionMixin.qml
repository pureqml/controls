///setup position mode of its parent
BaseMixin {
	property enum value { Absolute, Fixed, Relative, Static };	///< position mode value can be: Absolute, Fixed, Relative, Static

	onValueChanged (name, value): {
		switch (value) {
			case this.Absolute:
				this.parent.style('position', 'absolute');
				break;
			case this.Fixed:
				this.parent.style('position', 'fixed');
				break;
			case this.Relative:
				this.parent.style('position', 'relative');
				break;
			case this.Static:
				this.parent.style('position', 'static');
				break;
		}
	}
}
