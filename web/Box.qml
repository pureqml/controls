Object {
	property string top;
	property string left;
	property string right;
	property string bottom;
	property string prefix;	// dynamic update not supported!

	onTopChanged: { this.parent.style(this.prefix + 'top', value); }
	onLeftChanged: { this.parent.style(this.prefix + 'left', value); }
	onRightChanged: { this.parent.style(this.prefix + 'right', value); }
	onBottomChanged: { this.parent.style(this.prefix + 'bottom', value); }
}
