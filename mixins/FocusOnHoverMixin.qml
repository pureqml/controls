Item {
	anchors.fill: parent;
	property Mixin hoverClickMixin: HoverClickMixin {
		cursor: "pointer";

		onValueChanged: {
			if (value)
				this.parent.setFocus()
		}
	}
}
