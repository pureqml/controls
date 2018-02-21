/// is the same thing as usual Image but fill it's parent instead of placing it inside
Image {
	///@private
	function _createElement(tag) {
		this.element = this.parent.element;
	}
}
