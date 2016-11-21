Rectangle {
	property Mixin hoverMixin: HoverMixin {}
	property alias hover: hoverMixin.value;
	property alias clickable: hoverMixin.clickable;
	property alias hoverable: hoverMixin.enabled;
	property alias cursor: hoverMixin.cursor;
	property alias activeHover: hoverMixin.activeHover;
	property alias activeHoverEnabled: hoverMixin.activeHoverEnabled;
	color: "transparent";
	hoverMixin.cursor: "pointer";
	property string position;

	function _update(name, value) {
		switch (name) {
			case 'position': 
				this.style('position', value); 
				break
		}
		_globals.core.Rectangle.prototype._update.apply(this, arguments);
	}
}
