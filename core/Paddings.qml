/// class controlling internal paddings of the parent element
Object {
	property int top: all;		///< top padding
	property int left: all;		///< left padding
	property int right: all;	///< right padding
	property int bottom: all;	///< bottom padding
	property int all;			///< a value for all sides

	///@private
	onTopChanged: { this.parent.style('padding-top', value); }

	///@private
	onLeftChanged: { this.parent.style('padding-left', value); }

	///@private
	onRightChanged: { this.parent.style('padding-right', value); }

	///@private
	onBottomChanged: { this.parent.style('padding-bottom', value); }
}
