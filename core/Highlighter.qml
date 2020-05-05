Rectangle {
	property Object target;	///< target view for highlighter
	property string updatePositionProperty: "currentIndex";	///< which property must changed to update highlighter position
	width: 100;
	height: 100;
	color: "#fff";

	///@private
	function _updatePos() {
		var target = this.target
		var item = target.getItemPosition(target[this.updatePositionProperty])
		var horizontal = target.orientation ===  _globals.core.ListView.prototype.Horizontal
		if (horizontal) {
			this.x = target.x + item[0] - target.contentX
			this.y = target.y
			this.width = item[2]
		} else {
			this.x = target.x
			this.y = target.y + item[1] - target.contentY
			this.height = item[3]
		}
	}

	onCompleted: {
		var target = this.target
		this.connectOnChanged(target, this.updatePositionProperty, this._updatePos.bind(this))
		this.connectOnChanged(target, "count", this._updatePos.bind(this))
		this.connectOnChanged(target, "activeFocus", this._updatePos.bind(this))
		this.connectOnChanged(target, "contentHeight", this._updatePos.bind(this))
		this.connectOnChanged(target, "contentWidth", this._updatePos.bind(this))
		this._updatePos()
	}
}
