/// iframe item to embed other page
Item {
	property string source;		///< another page source URL

	///@private
	function getTag() { return 'iframe' }

	onSourceChanged: { this.element.dom.src = value; }
}
