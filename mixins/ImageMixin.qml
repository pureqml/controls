/// is the same thing as usual Image but fill it's parent instead of placing it inside
Image {
	width: 100%;	///< @private
	height: 100%;	///< @private

	///@private
	function createElement(tag) {
		this.element = this.parent.element;
	}
}
