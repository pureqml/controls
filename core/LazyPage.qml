/// Page for LazyPageStack
Item {
	property string name;			///< page name
	property string component;		///< page component path
	property Item manager: parent;	///< reference to PageStack item
	anchors.fill: manager;

	Loader {
		id: pageLoader;
		anchors.fill: parent.manager;
	}

	///create page
	function createPage() {
		var item = pageLoader.item
		if (!item) {
			pageLoader.source = this.component
			item = pageLoader.item
			item.anchors.fill = this
			this._context._processActions()
			item.manager = this.manager
			if (!item)
				throw new Error("can't create component " + this.component)
		}
		return pageLoader.item
	}

	///get page content item
	function getPage() {
		return pageLoader.item
	}

	onActiveFocusChanged: {
		var item = pageLoader.item
		if (item && value)
			item.setFocus()
	}
}
