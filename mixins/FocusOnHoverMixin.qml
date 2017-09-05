HoverClickMixin {
	cursor: "pointer";

	onValueChanged: {
		if (value)
			this.parent.setFocus()
	}
}
