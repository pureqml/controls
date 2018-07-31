Item {
	property string component;
	property Item manager: parent;
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

	function getPage() {
		return pageLoader.item
	}

	onActiveFocusChanged: {
		var item = pageLoader.item
		if (item && value)
			item.setFocus()
	}
}
