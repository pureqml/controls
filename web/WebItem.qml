///clickable and hoverable rectangle for mouse supportings applications
Rectangle {
	property Mixin hoverMixin: HoverClickMixin {}		///< hover mixin object proveds common API for mouse properties
	property alias hover: hoverMixin.value;			///< mouse hovered flag
	property alias clickable: hoverMixin.clickable;	///< flag which enables or disables mouse click event handling
	property alias hoverable: hoverMixin.enabled;	///< flag which enables or disables mouse hover event handling
	property alias cursor: hoverMixin.cursor;		///< mouse cursor property
	property alias activeHover: hoverMixin.activeHover;	///< flag which becames 'true' on 'mouseover' event and becames 'false' on 'mouseout' event
	property alias activeHoverEnabled: hoverMixin.activeHoverEnabled;	///< flag which enables or disables 'mouseover' and 'mouseout' event handling
	color: "transparent";				///< background color
	hoverMixin.cursor: "pointer";
	property string position;			///< position mode property

	/// @private
	onPositionChanged: { this.style('position', value); }
}
